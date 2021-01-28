
Palette = require "./Palette"
Color = require "./Color"

class LoadingErrors extends Error
	constructor: (@errors)->
		super()
		@message = "Some errors were encountered when loading:" +
			for error in @errors
				"\n\t" + error.message

# Formats are sorted by file extension if available,
# but it's not always available, and some formats use the same extensions.
# More generic formats should go at the bottom.
formats =
	PAINT_SHOP_PRO_PALETTE: {
		name: "Paint Shop Pro palette"
		fileExtensions: ["psppalette", "pal"]
		readFromText: require("./formats/PaintShopPro").read_paint_shop_pro_palette
		write: require("./formats/PaintShopPro").write_paint_shop_pro_palette
	}
	RIFF_PALETTE: {
		name: "RIFF PAL"
		fileExtensions: ["pal"]
		read: require("./formats/RIFF").read_riff_palette
		write: require("./formats/RIFF").write_riff_palette
	}
	COLORSCHEMER_PALETTE: {
		name: "ColorSchemer palette"
		fileExtensions: ["cs"]
		read: require("./formats/ColorSchemer").read_colorschemer_palette
	}
	PAINTDOTNET_PALETTE: {
		name: "Paint.NET palette"
		fileExtensions: ["txt"]
		readFromText: require("./formats/Paint.NET").read_paintdotnet_palette
		write: require("./formats/Paint.NET").write_paintdotnet_palette
	}
	GIMP_PALETTE: {
		name: "GIMP palette"
		fileExtensions: ["gpl", "gimp", "colors"]
		readFromText: require("./formats/GIMP").read_gpl
		write: require("./formats/GIMP").write_gpl
	}
	KDE_RGB_PALETTE: {
		name: "KolourPaint palette"
		fileExtensions: ["colors"]
		readFromText: require("./formats/KolourPaint").read_kolourpaint_palette
		write: require("./formats/KolourPaint").write_kolourpaint_palette
	}
	SKENCIL_PALETTE: {
		name: "Skencil palette"
		fileExtensions: ["spl"]
		readFromText: require("./formats/SPL").read_skencil_palette
		write: require("./formats/SPL").write_skencil_palette
	}
	SKETCH_JSON_PALETTE: {
		name: "Sketch palette"
		fileExtensions: ["sketchpalette"]
		readFromText: require("./formats/sketchpalette").read_sketchpalette
		write: require("./formats/sketchpalette").write_sketchpalette
	}
	SK1_PALETTE: {
		name: "sK1 palette"
		fileExtensions: ["skp"]
		readFromText: require("./formats/SKP").read_sk1_skp
		write: require("./formats/SKP").write_sk1_skp
	}
	WINDOWS_THEME_COLORS: {
		name: "Windows desktop theme"
		fileExtensions: ["theme", "themepack"]
		readFromText: require("./formats/theme").read_windows_theme
	}
	ADOBE_SWATCH_EXCHANGE_PALETTE: {
		name: "Adobe Swatch Exchange"
		fileExtensions: ["ase"]
		read: require("./formats/Adobe").read_adobe_swatch_exchange
		write: require("./formats/Adobe").write_adobe_swatch_exchange
	}
	ADOBE_COLOR_BOOK_PALETTE: {
		name: "Adobe Color Book"
		fileExtensions: ["acb"]
		read: require("./formats/Adobe").read_adobe_color_book
	}
	STAROFFICE_PALETTE: {
		name: "StarOffice Colors"
		fileExtensions: ["soc"]
		readFromText: require("./formats/StarOffice").read_soc
		write: require("./formats/StarOffice").write_libreoffice_soc
	}
	# KDE_THEME_COLORS: {
	# 	name: "KDE desktop theme"
	# 	fileExtensions: ["colors"]
	# 	read: require("./formats/theme").read_kde_theme
	# }
	CSS_VARIABLES: {
		name: "CSS variables"
		fileExtensions: ["css"]
		write: require("./formats/CSS").write_css
	}
	SCSS_VARIABLES: {
		name: "SCSS variables"
		fileExtensions: ["scss"]
		write: require("./formats/CSS").write_scss
	}
	SASS_VARIABLES: {
		name: "SASS variables"
		fileExtensions: ["sass"]
		write: require("./formats/CSS").write_sass
	}
	LESS_VARIABLES: {
		name: "LESS variables"
		fileExtensions: ["less"]
		write: require("./formats/CSS").write_less
	}
	STYLUS_VARIABLES: {
		name: "Stylus variables"
		fileExtensions: ["styl"]
		write: require("./formats/CSS").write_styl
	}
	CSS_COLORS: {
		name: "CSS colors"
		fileExtensions: ["css", "scss", "sass", "less", "styl", "html", "htm", "svg", "js", "ts", "xml", "txt"]
		readFromText: require("./formats/CSS").read_css_colors
	}
	HOMESITE_PALETTE: {
		name: "Homesite palette"
		fileExtensions: ["hpl"]
		readFromText: require("./formats/Homesite").read_hpl
		write: require("./formats/Homesite").write_hpl
	}
	ADOBE_COLOR_SWATCH_PALETTE: {
		name: "Adobe Color Swatch"
		fileExtensions: ["aco"]
		read: require("./formats/Adobe").read_adobe_color_swatch
		write: require("./formats/Adobe").write_adobe_color_swatch
	}
	ADOBE_COLOR_TABLE_PALETTE: {
		name: "Adobe Color Table"
		fileExtensions: ["act"]
		read: require("./formats/AdobeColorTable").read_adobe_color_table
		write: require("./formats/AdobeColorTable").write_adobe_color_table
	}
	STARCRAFT_PALETTE: {
		name: "StarCraft palette"
		fileExtensions: ["pal"]
		read: require("./formats/StarCraft").read_starcraft_pal
		write: require("./formats/StarCraft").write_starcraft_pal
	}
	STARCRAFT_PADDED: {
		name: "StarCraft terrain palette"
		fileExtensions: ["wpe"]
		read: require("./formats/StarCraftPadded").read_starcraft_wpe
		write: require("./formats/StarCraftPadded").write_starcraft_wpe
	}

	# AUTOCAD_COLOR_BOOK_PALETTE: {
	# 	name: "AutoCAD Color Book"
	# 	fileExtensions: ["acb"]
	# 	readFromText?: require("./formats/AutoCADColorBook").read_autocad_acb
	# }

	# CORELDRAW_PALETTE: {
	# 	# (same as Paint Shop Pro palette?)
	# 	name: "CorelDRAW palette"
	# 	fileExtensions: ["pal", "cpl"]
	# 	readFromText?: require("./formats/CorelDRAW").read_coreldraw_palette
	# }
	TABULAR: {
		name: "tabular colors"
		fileExtensions: ["csv", "tsv", "txt"]
		readFromText: require("./formats/tabular").read_tabular_colors
	}

for format_id in Object.keys(formats)
	format = formats[format_id]
	format.fileExtensionsPretty = ".#{format.fileExtensions.join(", .")}"

read_palette = (o, callback)->
	
	o.fileContentString = 
		if typeof o.data is "string"
			o.data
		else
			new TextDecoder().decode(o.data)

	# find formats that use this file extension
	matching_ext = {}
	for format_id in Object.keys(formats)
		if formats[format_id].fileExtensions.indexOf(o.fileExt) > -1
			matching_ext[format_id] = true
	
	# sort formats to the beginning that use this file extension
	format_ids = Object.keys(formats)
	format_ids.sort (format_id_1, format_id_2)->
		matching_ext[format_id_2]? - matching_ext[format_id_1]?
	
	# try loading stuff
	errors = []
	for format_id in format_ids
		format = formats[format_id]
		unless format.read or format.readFromText
			continue # skip this format
		try
			if format.readFromText
				palette = format.readFromText(o)
			else
				palette = format.read(o)
			if palette.length is 0
				palette = null
				throw new Error "no colors returned"
		catch e
			# TODO: should this be "failed to read"?
			msg = "failed to load #{o.fileName} as #{format.name}: #{e.message}"
			# msg = "failed to load #{o.fileName} as #{format.name}: #{if format_id.match(/staroffice/i) then e.stack else e.message}"
			# if matching_ext[format_id]? #and not e.message.match(/not a/i) # meant to avoid "Not a <FORMAT> Palette", overly broad
			# 	console?.error? msg
			# else
			# 	console?.warn? msg
			
			# TODO: maybe this shouldn't be an Error object, just a {message, error} object
			# or {friendlyMessage, error}
			err = new Error msg
			err.error = e
			errors.push err
		
		if palette
			# console?.info? "loaded #{o.fileName} as #{format.name}"
			callback(null, palette, format, matching_ext[format_id]?, __errors_before_success: errors)
			return
	
	callback(new LoadingErrors(errors))
	return

normalize_options = (o = {})->
	if typeof o is "string" or o instanceof String
		o = filePath: o
	if File? and o instanceof File
		o = file: o
	
	# o.minColors ?= 2
	# o.maxColors ?= 256
	o.fileName ?= o.file?.name ? (if o.filePath then require("path").basename(o.filePath))
	o.fileExt = "#{o.fileExt ? o.fileName}".split(".").pop()
	o

AnyPalette = {
	Color
	Palette
	# LoadingErrors
	formats
}

# Get palette from a file
AnyPalette.loadPalette = (o, callback)->
	if not o
		throw new TypeError "parameters required: AnyPalette.loadPalette(options, function callback(error, palette){})"
	if not callback
		throw new TypeError "callback required: AnyPalette.loadPalette(options, function callback(error, palette){})"
	
	o = normalize_options o
	
	if o.data
		read_palette(o, callback)
	else if o.file
		if not (o.file instanceof File)
			throw new TypeError "options.file was passed but it is not a File"
		fr = new FileReader
		fr.onerror = ->
			callback(fr.error)
		fr.onload = ->
			o.data = fr.result
			read_palette(o, callback)
		fr.readAsArrayBuffer o.file
	else if o.filePath?
		fs = require("fs")
		fs.readFile o.filePath, (error, data)->
			if error
				callback(error)
			else
				o.data = data
				read_palette(o, callback)
	else
		throw new TypeError "either options.data or options.file or options.filePath must be passed"

AnyPalette.writePalette = (palette, format)->
	format ?= AnyPalette.formats.GIMP_PALETTE
	return format.write(palette)
	# file = new File([palette_content_string], (palette.name ? "Saved Colors") + ".#{format.fileExtensions[0]}")
	# return [file, format.fileExtensions[0]]

AnyPalette.uniqueColors = (palette, epsilon)->
	new_palette = new Palette
	new_palette.name = @name
	new_palette.description = @description

	# These aren't super meaningful if some colors are removed:
	# new_palette.numberOfColumns = palette.numberOfColumns
	# new_palette.geometrySpecifiedByFile = palette.geometrySpecifiedByFile

	new_palette[..] = palette[..]
	# In-place uniquify
	# (Can't simply use `new_palette[..] = [...new Set(palette)]` because it's Color objects, not strings)
	i = 0
	while i < new_palette.length
		i_color = new_palette[i]
		j = i + 1
		while j < new_palette.length
			j_color = new_palette[j]
			if Color.is(i_color, j_color, epsilon)
				new_palette.splice(j, 1)
				j -= 1
			j += 1
		i += 1
	
	new_palette


# Exports
module.exports = AnyPalette
