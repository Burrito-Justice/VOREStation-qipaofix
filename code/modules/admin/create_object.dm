/datum/admins/proc/create_panel_helper(template)
	var/final_html = replacetext(template, "/* ref src */", "\ref[src];[HrefToken()]")
	final_html = replacetext(final_html,"/* hreftokenfield */","[HrefTokenFormField()]")
	return final_html

/datum/admins/proc/create_object(var/mob/user)
	var/static/create_object_html = null
	if (!create_object_html)
		var/objectjs = null
		objectjs = jointext(typesof(/obj), ";")
		create_object_html = file2text('html/create_object.html')
		create_object_html = replacetext(create_object_html, "null /* object types */", "\"[objectjs]\"")

	user << browse(create_panel_helper(create_object_html), "window=create_object;size=680x600")


/datum/admins/proc/quick_create_object(var/mob/user)

	var/quick_create_object_html = null
	var/pathtext = null
	var/list/choices = list("/obj",
	"/obj/structure",
	"/obj/item",
	"/obj/item",
	"/obj/item",
	"/obj/item/gun",
	"/obj/item/reagent_containers",
	"/obj/item/reagent_containers/food",
	"/obj/item/clothing",
	"/obj/item/storage/box/fluff", //VOREStation Edit,
	"/obj/machinery",
	"/obj/mecha",
	"/obj/item/mecha_parts",
	"/obj/item/mecha_parts/mecha_equipment")

	pathtext = tgui_input_list(usr, "Select the path of the object you wish to create.", "Path", choices, "/obj")

	if(!pathtext)
		return
	var path = text2path(pathtext)

	if (!quick_create_object_html)
		var/objectjs = null
		objectjs = jointext(typesof(path), ";")
		quick_create_object_html = file2text('html/create_object.html')
		quick_create_object_html = replacetext(quick_create_object_html, "null /* object types */", "\"[objectjs]\"")

	user << browse(create_panel_helper(quick_create_object_html), "window=quick_create_object;size=680x600")
