/obj/item/clothing/under/roguetown
	slot_flags = ITEM_SLOT_PANTS
	fitted = NO_FEMALE_UNIFORM
	can_adjust = FALSE
	body_parts_covered = GROIN|LEGS
	icon = 'icons/roguetown/clothing/pants.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/pants.dmi'
	equip_sound = 'sound/blank.ogg'
	drop_sound = 'sound/blank.ogg'
	pickup_sound =  'sound/blank.ogg'
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_pants.dmi'
	sleevetype = "leg"
	equip_delay_self = 30
	bloody_icon_state = "bodyblood"
	sewrepair = TRUE
	r_sleeve_zone = BODY_ZONE_R_LEG
	l_sleeve_zone = BODY_ZONE_L_LEG
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	flags_inv = HIDECROTCH
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/under/roguetown/AdjustClothes(mob/user)
#ifdef MATURESERVER
	if(loc == user)
		if(adjustable == CAN_CADJUST)
			adjustable = CADJUSTED
			icon_state = "[initial(icon_state)]_t"
			body_parts_covered = null
			slowdown += 2
			if(ishuman(user))
				var/mob/living/carbon/H = user
				H.update_inv_pants()
		else if(adjustable == CADJUSTED)
			ResetAdjust(user)
			if(user)
				if(ishuman(user))
					var/mob/living/carbon/H = user
					H.update_inv_pants()
#else
	return
#endif

/obj/item/clothing/under/roguetown/tights
	name = "tights"
	desc = "A pair of form fitting tights."
	gender = PLURAL
	icon_state = "tights"
	item_state = "tights"
//	adjustable = CAN_CADJUST

/obj/item/clothing/under/roguetown/tights/random/Initialize()
	color = pick("#544236", "#435436", "#543836", "#79763f")
	return ..()

/obj/item/clothing/under/roguetown/tights/black
	color = CLOTHING_BLACK

/obj/item/clothing/under/roguetown/tights/purple
	color = CLOTHING_PURPLE

/obj/item/clothing/under/roguetown/tights/jester
	desc = "Funny tights!"
	color = "#1E3B20"
	do_sound_bell = FALSE

/obj/item/clothing/under/roguetown/tights/lord
	color = "#865c9c"

/obj/item/clothing/under/roguetown/tights/vagrant
	r_sleeve_status = SLEEVE_TORN
	body_parts_covered = GROIN|LEG_LEFT
	torn_sleeve_number = 1

/obj/item/clothing/under/roguetown/tights/vagrant/l
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_TORN
	body_parts_covered = GROIN|LEG_RIGHT

/obj/item/clothing/under/roguetown/tights/vagrant/Initialize()
	color = pick("#6b5445", "#435436", "#704542", "#79763f")
	return ..()

/obj/item/clothing/under/roguetown/tights/sailor
	name = "pants"
	icon_state = "sailorpants"

/obj/item/clothing/under/roguetown/webs
	name = "webbing"
	desc = "a fine webbing made from spidersilk, popular fashion within the underdark"
	gender = PLURAL
	icon_state = "webs"
	item_state = "webs"
	r_sleeve_status = SLEEVE_NOMOD
	l_sleeve_status = SLEEVE_NOMOD
	salvage_result = /obj/item/natural/silk

/obj/item/clothing/under/roguetown/trou
	name = "work trousers"
	desc = "Good quality trousers worn by laborers."
	gender = PLURAL
	icon_state = "trou"
	item_state = "trou"
	max_integrity = 100
	sewrepair = TRUE
	armor = list("blunt" = 33, "slash" = 12, "stab" = 22, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT)
	blocksound = SOFTHIT
	blade_dulling = DULLING_BASHCHOP
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	salvage_amount = 1
	salvage_result = /obj/item/natural/cloth
	grid_width = 64
	grid_height = 64

/obj/item/clothing/under/roguetown/chainlegs
	name = "chain chausses"
	desc = "Steel chain leggings, composed of interlinked metal rings, that absorb arrow impacts decently enough."
	gender = PLURAL
	icon_state = "chain_legs"
	item_state = "chain_legs"
	max_integrity = 200
//	adjustable = CAN_CADJUST
	sewrepair = FALSE
	armor = list("blunt" = 60, "slash" = 100, "stab" = 80, "bullet" = 20, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_ASSASSIN)
	blocksound = CHAINHIT
	do_sound_chain = TRUE
	drop_sound = 'sound/foley/dropsound/chain_drop.ogg'
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/steel
	r_sleeve_status = SLEEVE_NOMOD
	l_sleeve_status = SLEEVE_NOMOD
	w_class = WEIGHT_CLASS_NORMAL
	resistance_flags = FIRE_PROOF

/obj/item/clothing/under/roguetown/brayette
	name = "brayette"
	desc = "Chain underwear which protect the family jewels."
	gender = PLURAL
	icon_state = "chain_bootyshorts"
	item_state = "chain_bootyshorts"
	max_integrity = 325
	sewrepair = FALSE
	armor = list("blunt" = 70, "slash" = 100, "stab" = 80, "bullet" = 50, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT)
	body_parts_covered = GROIN
	blocksound = CHAINHIT
	drop_sound = 'sound/foley/dropsound/chain_drop.ogg'
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/steel
	r_sleeve_status = SLEEVE_NOMOD
	l_sleeve_status = SLEEVE_NOMOD
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FIRE_PROOF

/obj/item/clothing/under/roguetown/chainlegs/iron
	desc = "Iron chain leggings, composed of interlinked metal rings, that absorb arrow impacts decently enough."
	icon_state = "ichain_legs"
	anvilrepair = /datum/skill/craft/blacksmithing
	max_integrity = 175
	smeltresult = /obj/item/ingot/iron

/obj/item/clothing/under/roguetown/platelegs
	name = "plated chausses"
	desc = "Plated armor to protect the legs, especially against arrows."
	gender = PLURAL
	icon_state = "plate_legs"
	item_state = "plate_legs"
//	adjustable = CAN_CADJUST
	armor_class = ARMOR_CLASS_HEAVY
	sewrepair = FALSE
	armor = list("blunt" = 90, "slash" = 100, "stab" = 80, "bullet" = 50, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT)
	blocksound = PLATEHIT
	do_sound_plate = TRUE
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/steel
	r_sleeve_status = SLEEVE_NOMOD
	l_sleeve_status = SLEEVE_NOMOD
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FIRE_PROOF

/obj/item/clothing/under/roguetown/loincloth
	name = "loincloth"
	desc = "Covers your dignity, but only just."
	icon_state = "loincloth"
	item_state = "loincloth"
//	adjustable = CAN_CADJUST
	r_sleeve_status = SLEEVE_NOMOD
	l_sleeve_status = SLEEVE_NOMOD
	fiber_salvage = FALSE
	salvage_amount = 1

/obj/item/clothing/under/roguetown/loincloth/brown
	color = CLOTHING_BROWN

/obj/item/clothing/under/roguetown/loincloth/pink
	color = "#b98ae3"

/obj/item/clothing/under/roguetown/grenzelpants
	name = "grenzelhoftian paumpers"
	desc = "Padded pants for extra comfort and protection, adorned in vibrant colors."
	icon_state = "grenzelpants"
	item_state = "grenzelpants"
	sleeved = 'icons/roguetown/clothing/onmob/helpers/stonekeep_merc.dmi'
	detail_tag = "_detail"
	armor = list("blunt" = 45, "slash" = 30, "stab" = 35, "bullet" = 15, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT)
	blocksound = SOFTUNDERHIT
	blade_dulling = DULLING_BASHCHOP
	armor_class = ARMOR_CLASS_LIGHT
	colorgrenz = TRUE

/obj/item/clothing/under/roguetown/grenzelpants/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/under/roguetown/splintlegs
	name = "brigandine chausses"
	desc = "Splint mail and brigandine chausses, designed to protect the legs while still providing almost complete free range of movement."
	icon_state = "splintlegs"
	item_state = "splintlegs"
	max_integrity = 250
	armor = list("blunt" = 60, "slash" = 70, "stab" = 70, "bullet" = 60, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT)
	blocksound = SOFTHIT
	drop_sound = 'sound/foley/dropsound/chain_drop.ogg'
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/iron
	r_sleeve_status = SLEEVE_NOMOD
	l_sleeve_status = SLEEVE_NOMOD
	armor_class = ARMOR_CLASS_MEDIUM
	w_class = WEIGHT_CLASS_NORMAL
	resistance_flags = FIRE_PROOF
	sewrepair = FALSE

//----------------- BLACKSTEEL---------------------

/obj/item/clothing/under/roguetown/blacksteel/platelegs
	name = "blacksteel plate chausses"
	desc = "Reinforced leg plates forged of durable blacksteel."
	gender = PLURAL
	icon = 'icons/roguetown/clothing/special/blkknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	icon_state = "bklegs"
	item_state = "bklegs"
	max_integrity = 300
//	adjustable = CAN_CADJUST
	resistance_flags = FIRE_PROOF
	sewrepair = FALSE
	armor = list("blunt" = 90, "slash" = 100, "stab" = 80, "bullet" = 50, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT)
	blocksound = PLATEHIT
	var/do_sound = FALSE
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/blacksteel
	r_sleeve_status = SLEEVE_NOMOD
	l_sleeve_status = SLEEVE_NOMOD

//---------------- NEW/PANTS.DM--------------------

/obj/item/clothing/under/roguetown/shadow
	name = "silk pants"
	desc = "Pants made from silk, famous choice for wealthy people that don't have to worry about it getting dirty with mud."
	gender = PLURAL
	icon = 'icons/roguetown/clothing/pants.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/pants.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_pants.dmi'
	icon_state = "shadowpants"
	max_integrity = 150
	sewrepair = TRUE
	blocksound = SOFTHIT
	blade_dulling = DULLING_BASHCHOP
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	salvage_amount = 1
	salvage_result = /obj/item/natural/silk

//---------------- LEATHER/PANTS.DM--------------------

/obj/item/clothing/under/roguetown/trou/leather
	name = "leather trousers"
	desc = "Trousers made of fine leather."
	icon_state = "leatherpants"
	max_integrity = 130
	armor = list("blunt" = 50, "slash" = 25, "stab" = 40, "bullet" = 10, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB)
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/under/roguetown/trou/leather/advanced
	name = "hardened leather chausses"
	desc = "Sturdy, durable, flexible. The finest leather to protect your nether regions."
	icon_state = "leatherpants_masterwork" //no advanced sprite
	max_integrity = 200
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST)
	armor = list("blunt" = 70, "slash" = 60, "stab" = 30, "bullet" = 20, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/under/roguetown/trou/leather/masterwork
	name = "masterwork leather chausses"
	desc = "These chausses are a craftsmanship marvel. Made with the finest leather. Strong, nimible, reliable."
	max_integrity = 250
	icon_state = "leatherpants_masterwork"
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST, BCLASS_CHOP)
	armor = list("blunt" = 100, "slash" = 70, "stab" = 40, "bullet" = 20, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	filters = filter(type="drop_shadow", x=0, y=0, size=0.5, offset=1, color=rgb(218, 165, 32))

/obj/item/clothing/under/roguetown/trou/leather/mourning
	name = "mourning trousers"
	desc = "Dark trousers worn by morticians while performing burial rites."
	icon_state = "trou"
	color = "#151615"

//Gronn
/obj/item/clothing/under/roguetown/trou/nomadpants
	name = "nomad pants"
	desc = "Tight fitting leather pants worn under clothing of the steppes."
	icon_state = "nomadpants"
	max_integrity = 130
	armor = list("blunt" = 20, "slash" = 25, "stab" = 20, "bullet" = 5, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB)
	salvage_result = /obj/item/natural/hide/cured

//----------------- MORE AZURE SPRITEWORK ---------------------

/obj/item/clothing/under/roguetown/trou/leather/pontifex
	name = "monk trousers"
	desc = "A handmade pair of baggy, thin leather pants. They end in a tight stocking around the calf, ballooning out around the thigh."
	icon_state = "monkpants"
	item_state = "monkpants"

/obj/item/clothing/under/roguetown/heavy_leather_pants/shorts
	name = "heavy leather shorts"
	desc = "A thick hide pair of shorts, favored by some for their ease of motion in spite of \
	being less protective than full trousers."
	icon_state = "rogueshorts"
	item_state = "rogueshorts"
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT)
	body_parts_covered = GROIN

/obj/item/clothing/under/roguetown/trou/otavan
	name = "fencer leather trousers"
	desc = "padded leather armor made by the most skilled of kingsfield's tailors, its quality is remarkable."
	icon_state = "fencerpants"
	resistance_flags = FIRE_PROOF
	armor = list("blunt" = 60, "slash" = 65, "stab" = 85, "bullet" = 20, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_CHOP, BCLASS_BLUNT)
	blocksound = SOFTHIT
	max_integrity = 200
	blade_dulling = DULLING_BASHCHOP
	sewrepair = TRUE
	allowed_race = NON_DWARVEN_RACE_TYPES

/obj/item/clothing/under/roguetown/trou/apothecary
	name = "apothecary trousers"
	desc = "Heavily padded trousers. They're stained by countless herbs."
	icon_state = "apothpants"
	item_state = "apothpants"

/obj/item/clothing/under/roguetown/trou/artipants
	name = "tinker trousers"
	desc = "Thick leather trousers to protect from sparks or stray gear projectiles. Judging by the wear, its had plenty of use."
	icon_state = "artipants"
	item_state = "artipants"
	resistance_flags = FIRE_PROOF	//Artificers contraptions set them on fire with regular intervals. Thus, Fire retardent clothing.

/obj/item/clothing/under/roguetown/trou/leathertights
	name = "leather tights"
	desc = "Classy leather tights, form-fitting but tasteful."
	icon_state = "leathertights"
	item_state = "leathertights"

/obj/item/clothing/under/roguetown/trou/beltpants
	name = "belt-buckled trousers"
	desc = "Dark leather trousers adorned with far too many buckles to be pragmatic."
	icon_state = "beltpants"
	item_state = "beltpants"

/obj/item/clothing/under/roguetown/skirt
	name = "skirt"
	desc = "Long, flowing, and modest."
	icon_state = "skirt"
	item_state = "skirt"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/pants.dmi'

/obj/item/clothing/under/roguetown/skirt/random
	name = "skirt"

/obj/item/clothing/under/roguetown/skirt/random/Initialize()
	color = pick("#6b5445", "#435436", "#704542", "#79763f", CLOTHING_BLUE)
	..()

/obj/item/clothing/under/roguetown/skirt/blue
	color = CLOTHING_BLUE

/obj/item/clothing/under/roguetown/skirt/green
	color = CLOTHING_GREEN

/obj/item/clothing/under/roguetown/skirt/red
	color = CLOTHING_RED


/obj/item/clothing/under/roguetown/trou/overseer
    name = "heavy trousers"
    desc = "A pair of washed-out heavy trousers in grey colors."
    icon_state = "overseerpants"
    item_state = "overseerpants"
    icon = 'icons/roguetown/clothing/inquisition_overseers/overseer.dmi'
    mob_overlay_icon = 'icons/roguetown/clothing/inquisition_overseers/onmob/overseer_onmob.dmi'
    sleeved = 'icons/roguetown/clothing/inquisition_overseers/onmob/overseer_onmob.dmi'
    max_integrity = 110
    armor = list("blunt" = 35, "slash" = 25, "stab" = 20, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
    prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT)
