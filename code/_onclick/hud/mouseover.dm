/*
/mob/living
	var/tmp/image/move_indicator

/turf/MouseEntered(location,control,params)
	if(istype(usr, /mob/living))
		var/mob/living/p = usr
		if(!p.move_indicator)
			p.move_indicator = image('icons/mouseover.dmi',src,"mouseover",ABOVE_HUD_LAYER,null)
			p.move_indicator.pixel_x = -1
			p.move_indicator.pixel_y = -1
			p <<  p.move_indicator
		else
			world << "[src.x] [src.y]" //outputs the turf's x/y
			p.move_indicator.loc = src //set to turf I entered before this /turf
			world << "[p.move_indicator.x] [p.move_indicator.y]" //outputs the turf's x/y, they match
*/

/atom
	/// This means that the mouse over text will not be displayed when the mouse is over this atom
	var/nomouseover = FALSE

/atom/MouseEntered(location,control,params)
	. = ..()
	if(!nomouseover && name && ismob(usr))
		handle_mouseover(location, control, params)

/atom/MouseExited(params)
	. = ..()
	if(!nomouseover && ismob(usr))
		handle_mouseexit(params)

/atom/proc/handle_mouseover(location, control, params)
	var/mob/p = usr
	if(QDELETED(src))
		return FALSE
	if(p.client)
		if(!p.client.mouseovertext)
			p.client.genmouseobj()
			return FALSE
		if(p.client.pixel_x || p.client.pixel_y)
			return FALSE
		if(!p.x || !p.y)
			return FALSE
		var/offset_x = 8 - (p.x - x)
		var/offset_y = 8 - (p.y - y)
		var/list/PM = list("screen-loc" = "[offset_x]:0,[offset_y]:0")
		if(!isturf(loc))
			PM = params2list(params)
			p.client.mouseovertext.movethis(PM, TRUE)
		else
			p.client.mouseovertext.movethis(PM)
		p.client.mouseovertext.maptext = {"<span style='font-size:8pt;font-family:"Pterra";color:#ddd7df;text-shadow:0 0 10px #fff, 0 0 20px #fff, 0 0 30px #e60073, 0 0 40px #e60073, 0 0 50px #e60073, 0 0 60px #e60073, 0 0 70px #e60073;' class='center maptext '>[name]"}
		p.client.screen |= p.client.mouseovertext
	return TRUE

/atom/proc/handle_mouseexit(params)
	var/mob/p = usr
	if(p.client)
		if(!p.client.mouseovertext)
			p.client.genmouseobj()
			return FALSE
		p.client.mouseovertext.screen_loc = null
	return TRUE

/*
/turf/MouseEntered(location,control,params)
	. = ..()
	if(!density)
		return
	if(istype(usr, /mob) && !nomouseover)
		var/list/PM = params2list(params)
		var/mob/p = usr
		if(p.boxaim && p.client)
			p.client.mouseoverbox.movethis(PM)

/turf/MouseExited(params)
	. = ..()
	if(!density)
		return
	if(!nomouseover)
		var/mob/living/p = usr
		if(p.boxaim && p.client)
			p.client.mouseoverbox.screen_loc = null
*/

/turf/handle_mouseover(location,control,params)
	var/mob/p = usr
	if(QDELETED(src))
		return FALSE
	if(p.client)
		if(!p.client.mouseovertext)
			p.client.genmouseobj()
			return FALSE
		if(p.client.pixel_x || p.client.pixel_y)
			return FALSE
		if(!p.x || !p.y)
			return FALSE
		var/offset_x = 8 - (p.x - x)
		var/offset_y = 8 - (p.y - y)
		if(offset_x < 1 || offset_x > 15 || offset_y < 1 || offset_x > 15)
			return FALSE
		var/list/PM = list("screen-loc" = "[offset_x]:0,[offset_y]:0")
		p.client.mouseovertext.maptext = {"<span style='font-size:8pt;font-family:"Pterra";color:#607d65;text-shadow:0 0 10px #fff, 0 0 20px #fff, 0 0 30px #e60073, 0 0 40px #e60073, 0 0 50px #e60073, 0 0 60px #e60073, 0 0 70px #e60073;' class='center maptext '>[name]"}
		p.client.mouseovertext.movethis(PM)
		p.client.screen |= p.client.mouseovertext
	return TRUE

/turf/open
	nomouseover = TRUE

/turf/open/handle_mouseover(location, control, params)
	var/mob/p = usr
	if(QDELETED(src))
		return FALSE
	if(p.client)
		if(!p.client.mouseovertext)
			p.client.genmouseobj()
			return FALSE
		if(p.client.pixel_x || p.client.pixel_y)
			return FALSE
		if(!p.x || !p.y)
			return FALSE
		var/offset_x = 8 - (p.x - x)
		var/offset_y = 8 - (p.y - y)
		var/list/PM = list("screen-loc" = "[offset_x]:0,[offset_y]:0")
		p.client.mouseovertext.maptext = {"<span style='font-size:8pt;font-family:"Pterra";color:#6b3f3f;text-shadow:0 0 10px #fff, 0 0 20px #fff, 0 0 30px #e60073, 0 0 40px #e60073, 0 0 50px #e60073, 0 0 60px #e60073, 0 0 70px #e60073;' class='center maptext '>[name]"}
		p.client.mouseovertext.movethis(PM)
		p.client.screen |= p.client.mouseovertext
	return TRUE

/mob/handle_mouseover(location,control,params)
	var/mob/p = usr
	if(QDELETED(src))
		return FALSE
	if(p.client)
		if(!p.client.mouseovertext)
			p.client.genmouseobj()
			return FALSE
		if(isliving(p))
			var/mob/living/L = p
			if(!L.can_see_cone(src))
				return FALSE
		if(p.client.pixel_x || p.client.pixel_y)
			return FALSE
		if(alpha == 0)
			return FALSE
		if(!p.x || !p.y)
			return FALSE
		var/offset_x = 8 - (p.x - x)
		var/offset_y = 8 - (p.y - y)
		var/list/PM = list("screen-loc" = "[offset_x]:0,[offset_y]:0")
		var/mousecolor = "#c1aaaa"
		if(ishuman(src))
			var/mob/living/carbon/human/H = src
			if(H.voice_color)
				if(H.name != "Unknown")
					mousecolor = "#[H.voice_color]"
		p.client.mouseovertext.maptext = {"<span style='font-size:8pt;font-family:"Pterra";color:[mousecolor];text-shadow:0 0 10px #fff, 0 0 20px #fff, 0 0 30px #e60073, 0 0 40px #e60073, 0 0 50px #e60073, 0 0 60px #e60073, 0 0 70px #e60073;' class='center maptext '>[name]"}
		p.client.mouseovertext.movethis(PM)
		p.client.screen |= p.client.mouseovertext
	return TRUE

/atom/movable/screen
	nomouseover = TRUE

/atom/movable/screen/movable/mouseover
	name = ""
	icon = 'icons/mouseover.dmi'
	icon_state = "mouseover"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	layer = ABOVE_HUD_LAYER+1
	plane = HUD_PLANE + 1

/atom/movable/screen/movable/mouseover/maptext
	name = ""
	icon = null
	icon_state = null
	maptext = "MOUSEOVER"
	maptext_width = 96
	alpha = 150

/atom/movable/screen/movable/mouseover/proc/movethis(list/PM, hudobj = FALSE)
	if(locked) //no! I am locked! begone!
		return

	//No screen-loc information? abort.
	if(!PM || !PM["screen-loc"])
//		testing("Can't find parameters for that mouseover.")
		return

	//Split screen-loc up into X+Pixel_X and Y+Pixel_Y
	var/list/screen_loc_params = splittext(PM["screen-loc"], ",")

	//Split X+Pixel_X up into list(X, Pixel_X)
	var/list/screen_loc_X = splittext(screen_loc_params[1],":")

	//Split Y+Pixel_Y up into list(Y, Pixel_Y)
	var/list/screen_loc_Y = splittext(screen_loc_params[2],":")

	//Normalise Pixel Values (So the object drops at the center of the mouse, not 16 pixels off)
	var/pix_X = text2num(screen_loc_X[2])
	var/pix_Y = text2num(screen_loc_Y[2])

	if(hudobj)
		maptext_y = 28
		maptext_x = -48
		pix_Y = 0
	else
		maptext_y = 28
		maptext_x = -32

	screen_loc = "[screen_loc_X[1]]:[pix_X],[screen_loc_Y[1]]:[pix_Y]"

	moved = screen_loc

/client/proc/genmouseobj()
	mouseovertext = new /atom/movable/screen/movable/mouseover/maptext
	mouseoverbox = new /atom/movable/screen/movable/mouseover
	//var/datum/asset/stuff = get_asset_datum(/datum/asset/simple/roguefonts)
	//stuff.send(src)
