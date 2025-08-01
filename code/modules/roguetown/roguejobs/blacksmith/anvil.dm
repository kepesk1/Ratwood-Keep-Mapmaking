
/obj/machinery/anvil
	icon = 'icons/roguetown/misc/forge.dmi'
	name = "iron anvil"
	desc = "It's surface is marred by countless hammer strikes."
	icon_state = "anvil"
	var/hott = null
	max_integrity = 500
	density = TRUE
	damage_deflection = 25
	climbable = TRUE
	smeltresult = /obj/item/ingot/iron
	anchored = FALSE
	drag_slowdown = 10
	var/advance_multiplier = 1 //Lower for auto-striking

/obj/machinery/anvil/crafted
	icon_state = "caveanvil"

/obj/machinery/anvil/examine(mob/user)
	. = ..()
	var/obj/item/ingot/hingot = get_ingot()
	if(has_ingot() && hingot.ishot)
		. += span_warning("[hingot] is too hot to touch.")

/obj/machinery/anvil/attackby(obj/item/W, mob/living/user, params)
	var/obj/item/ingot/hingot = get_ingot()
	if(istype(W, /obj/item/rogueweapon/tongs))
		var/obj/item/rogueweapon/tongs/T = W
		var/obj/item/ingot/tong_ingot = T.get_ingot()
		if(hingot)
			if(tong_ingot)
				if(hingot.currecipe && hingot.currecipe.needed_item && istype(tong_ingot, hingot.currecipe.needed_item))
					hingot.currecipe.item_added(user)
					qdel(tong_ingot)
					T.update_icon()
					update_icon()
					return
				return
			else
				hingot.forceMove(T)
				T.update_icon()
				update_icon()
				return
		else
			if(tong_ingot && istype(tong_ingot, /obj/item/ingot))
				tong_ingot.forceMove(src)
				T.update_icon()
				update_icon()
				return

	if(istype(W, /obj/item/ingot))
		if(!has_ingot())
			W.forceMove(src)
			update_icon()
			return

	if(istype(W, /obj/item/rogueweapon/hammer))
		user.changeNext_move(CLICK_CD_MELEE)
		var/obj/item/rogueweapon/hammer/hammer = W
		if(!hingot)
			return
		if(!hingot.currecipe)
			if(!choose_recipe(user))
				return
		advance_multiplier = 1 //Manual striking more effective than manual striking.
		user.doing = FALSE
		spawn(1)
			while(has_ingot())
				if(!hingot.ishot)
					to_chat(user, span_warning("It's too cold."))
					return
				if(!hingot.currecipe)
					return
				var/used_str = user.STASTR
				if(iscarbon(user))
					var/mob/living/carbon/carbon_user = user
					if(carbon_user.domhand)
						used_str = carbon_user.get_str_arms(carbon_user.used_hand)
					if(HAS_TRAIT(carbon_user, TRAIT_FORGEBLESSED))
						carbon_user.stamina_add(max(21 - (used_str * 3), 0)*advance_multiplier)
					else
						carbon_user.stamina_add(max(30 - (used_str * 3), 0)*advance_multiplier)
				var/total_chance = 7 * user.mind.get_skill_level(hingot.currecipe.appro_skill) * (user.STAPER + user.STAINT)/20 * hammer.quality
				var/breakthrough = 0
				if(prob((1 + total_chance)*advance_multiplier)) //Small chance to flash
					user.flash_fullscreen("whiteflash")
					var/datum/effect_system/spark_spread/S = new()
					var/turf/front = get_turf(src)
					S.set_up(1, 1, front)
					S.start()
					breakthrough = 1

				if(!hingot.currecipe.advance(user, breakthrough, advance_multiplier))
					shake_camera(user, 1, 1)
					playsound(src,'sound/items/bsmithfail.ogg', 100, FALSE)
					update_icon()
					break
				playsound(src,pick('sound/items/bsmith1.ogg','sound/items/bsmith2.ogg','sound/items/bsmith3.ogg','sound/items/bsmith4.ogg'), 100, FALSE)
				if(do_after(user, 20, target = src)) //Let's do it all over again!
					advance_multiplier = 0.50
				else
					break
		user.changeNext_move(user.used_intent.clickcd)
		return


	if(hingot && hingot.currecipe && hingot.currecipe.needed_item && istype(W, hingot.currecipe.needed_item))
		hingot.currecipe.item_added(user)
		qdel(W)
		return
	
	if(W.anvilrepair)
		if(user.cmode)
			..()
		else
			user.visible_message(span_info("[user] places [W] on the anvil."))
			W.forceMove(src.loc)
			return
	..()


/obj/machinery/anvil/proc/has_ingot()
	if(locate(/obj/item/ingot) in src)
		return TRUE
	return FALSE

/obj/machinery/anvil/proc/get_ingot()
	if(has_ingot())
		return locate(/obj/item/ingot) in src

/obj/machinery/anvil/proc/choose_recipe(user)
	var/obj/item/ingot/Ingot_check = get_ingot()
	if(!Ingot_check || !Ingot_check.ishot)
		return

	var/list/valid_types = list()

	for(var/datum/anvil_recipe/R in GLOB.anvil_recipes)
		if(istype(get_ingot(), R.req_bar))
			if(!valid_types.Find(R.i_type))
				valid_types += R.i_type

	if(!valid_types.len)
		return

	var/i_type_choice = input(user, "Choose a type", "Anvil") as null|anything in valid_types
	if(!i_type_choice)
		return

	var/list/appro_recipe = list()
	for(var/datum/anvil_recipe/R in GLOB.anvil_recipes)
		if(R.i_type == i_type_choice && istype(get_ingot(), R.req_bar))
			appro_recipe += R

	for(var/I in appro_recipe)
		var/datum/anvil_recipe/R = I
		if(!R.req_bar)
			appro_recipe -= R
		if(!istype(get_ingot(), R.req_bar))
			appro_recipe -= R

	if(appro_recipe.len)
		var/datum/chosen_recipe = input(user, "Choose A Creation", "Anvil") as null|anything in sortNames(appro_recipe.Copy())
		if(!get_ingot().currecipe && chosen_recipe)
			get_ingot().currecipe = new chosen_recipe.type(get_ingot())
			return TRUE

	return FALSE

/obj/machinery/anvil/attack_hand(mob/user, params)
	var/obj/item/ingot/I = get_ingot()
	
	if(I && I.ishot && ishuman(user))
		var/mob/living/carbon/human/H = user
		var/index = H.active_hand_index
		var/bp = H.get_bodypart(BODY_ZONE_PRECISE_L_HAND)
		if(index == 2)
			bp = H.get_bodypart(BODY_ZONE_PRECISE_R_HAND)
		H.apply_damage(20, BRUTE, bp)
		H.emote("scream")
		H.Stun(10)
		H.visible_message(span_warn("[H.name] burns [user.p_their()] hand on the [name]!"))
		return

	I.loc = get_turf(user)
	user.put_in_active_hand(I)
	update_icon()

/obj/machinery/anvil/process()
	if(hott)
		if(world.time > hott + 10 SECONDS)
			hott = null
			STOP_PROCESSING(SSmachines, src)
	else
		STOP_PROCESSING(SSmachines, src)
	update_icon()

/obj/machinery/anvil/update_icon()
	cut_overlays()
	if(has_ingot())
		var/obj/item/ingot/I =  get_ingot()
		I.pixel_x = 0
		I.pixel_y = 0
		var/mutable_appearance/M = new /mutable_appearance(I)
		if(I.ishot)
			M.filters += filter(type="color", color = list(3,0,0,1, 0,2.7,0,0.4, 0,0,1,0, 0,0,0,1))
		M.transform *= 0.5
		M.pixel_y = 5
		M.pixel_x = 3
		add_overlay(M)
