
# Load tabular RGB values

Palette = require "../Palette"

module.exports = ({fileContentString})->
	lines = fileContentString.split(/[\n\r]+/m)
	palettes = [
		csv_palette = new Palette()
		ssv_palette = new Palette()
	]
	try_parse_line = (line, palette, regexp)->
		match = line.match(regexp)
		if match
			palette.add
				red: Number(match[1]) / 255
				green: Number(match[2]) / 255
				blue: Number(match[3]) / 255
	for line in lines
		try_parse_line line, csv_palette, /([0-9]*\.?[0-9]+),\s*([0-9]*\.?[0-9]+),\s*([0-9]*\.?[0-9]+)/
		try_parse_line line, ssv_palette, /([0-9]*\.?[0-9]+)\s+([0-9]*\.?[0-9]+)\s+([0-9]*\.?[0-9]+)/
	
	most_colors = []
	for palette in palettes
		if palette.length >= most_colors.length
			most_colors = palette
	
	n = most_colors.length
	if n < 4
		throw new Error([
			"No colors found"
			"Only one color found"
			"Only a couple colors found"
			"Only a few colors found"
		][n] + " (#{n})")
	
	if most_colors.every((color)-> color.red <= 1/255 and color.green <= 1/255 and color.blue <= 1/255)
		most_colors.forEach (color)->
			color.red *= 255
			color.green *= 255
			color.blue *= 255

	most_colors
