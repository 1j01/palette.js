fs = require 'fs'
path = require 'path'
glob = require 'glob'
mkdirp = require 'mkdirp'
AnyPalette = require '../build/anypalette-dev.js'

# TODO: maybe return a non-zero exit code if there are changes between the output and what's in git
# i.e. a git status "#{__dirname}/regression-data" with changes listed... other than FOLDER-README.md ideally
# maybe FOLDER-README.md should just be above, in this folder (tests/)?

# Some inputs that have interesting characteristics, like columns but no name, name but no columns, etc.
writer_test_file_path_regexp = ///
	ios.sketchpalette # number precision - some palette formats need to round to avoid a decimal point
	|palettes/sk1_palette_collection_1.0/SKP/Color_names_supported_by_all_browsers.skp # named colors, number precision, multiline description
	|KDE40.colors # no columns, no palette name, named colors
	|Nord.gpl # palette name, palette columns, named colors
	|emoji-average-colors.gpl # Unicode color names, many colors
///

glob "#{__dirname.replace(/\\/g, "/")}/regression-data/**/*.out.*", (err, file_paths)->
	if err
		throw err
	for file_path in file_paths
		fs.unlinkSync(file_path)
	console.log "Cleared regression-data folder of all *.out.* files"

	# forward slashes required for glob, but also using this to determine the subfolders for output
	palettes_folder = "#{__dirname.replace(/\\/g, "/")}/../palettes"
	# only match within at least one directory level inside the palettes folder
	glob "#{palettes_folder}/*/**/*", ignore: "**/node_modules/**", nodir: true, (err, file_paths)->
		if err
			throw err
		if file_paths.length is 0
			console.error("No palette files found in #{palettes_folder}.\nMake sure to run: git submodule update --init")
			return
		for file_path in file_paths
			do (file_path)->
				relative_path = path.relative(palettes_folder, file_path)
				options = file_path
				# To test loading from a Node.js Buffer:
				# data = fs.readFileSync(file_path)
				# options = {fileName: require("path").basename(file_path), data}
				# To test loading from a binary string:
				# data = fs.readFileSync(file_path, "binary")
				# options = {fileName: require("path").basename(file_path), data}
				AnyPalette.loadPalette options, (err, palette, formatUsed, matchedFileExtension, {__errors_before_success}={})->
					result =
						if err
							err.message
						else
							# TODO: add a "Can Parse Without Knowing Ext:"
							# - pass {fileExt: null} and make sure / make it so this is treated as explicitly ignoring file extensions
							# - check that it parses exactly the same, including geometry
							"""
							Loaded As:                      #{formatUsed.name} (#{formatUsed.fileExtensionsPretty})

							matchedFileExtension:           #{matchedFileExtension}
							geometrySpecifiedByFile:        #{palette.geometrySpecifiedByFile}
							numberOfColumns:                #{palette.numberOfColumns}

							Colors (in GPL format):
							#{AnyPalette.writePalette(palette, AnyPalette.formats.GIMP_PALETTE)}

							"""
					output_file_path = path.join(__dirname, "regression-data", relative_path + ".out.txt")
					mkdirp.sync	path.dirname(output_file_path)
					fs.writeFileSync output_file_path, result, "utf8"
					console.log "Wrote", (if err then "failed" else "parsed"), output_file_path

					if file_path.match(/\.soc/) and not matchedFileExtension
						console.error ".soc files (see file in above line) must parse with the appropriate loader#{if formatUsed then " (parsed as '#{formatUsed.name}' instead)" else " - got error: #{err}"}"
						console.error "Errors before it 'successfully' parsed:\n#{
							for error in __errors_before_success
								"\n\t" + "#{error.stack}".replace(/\n/g, "\n\t")
						}"
			# msg = "failed to load #{o.fileName} as #{format.name}: #{if format_id.match(/staroffice/i) then e.stack else e.message}"

						process.exit(1)

					# test writers
					if not palette
						return
					if file_path.match(writer_test_file_path_regexp)
						for format_id in Object.keys(AnyPalette.formats)
							do (format_id)->
								format = AnyPalette.formats[format_id]
								if format.write
									file_extension = if format_id is "STARCRAFT_PALETTE" then "sc.pal" else format.fileExtensions[0] # avoid collision with RIFF .pal output
									output_file_path = path.join(__dirname, "regression-data", "writing", "#{path.basename(file_path)}.out.#{file_extension}")
									mkdirp.sync	path.dirname(output_file_path)
									result = AnyPalette.writePalette(palette, format)
									fs.writeFileSync output_file_path, result, "utf8"
									console.log "Wrote", format_id, output_file_path

									AnyPalette.loadPalette {data: result, filePath: output_file_path}, (err, reparsed_palette, reparsed_as_format, matched_file_extension)->
										if err
											console.error "Reparsing failed - #{err}"
											process.exit(1)
											return
										if reparsed_as_format isnt format and (format.read or format.readFromText)
											console.log("Reparsed as format:", reparsed_as_format)
											console.log("Original format:", format)
											console.error "Reparsed with a different format (#{reparsed_as_format.name} rather than #{format.name})"
											process.exit(1)
										if reparsed_palette.length isnt palette.length and reparsed_palette.length isnt 256
											console.log("Reparsed:", [reparsed_palette...].map((color)-> color.toString()))
											console.log("Original:", [palette...].map((color)-> color.toString()))
											console.error "Reparsing failed - differing numbers of colors!"
											process.exit(1)
										if reparsed_palette.every((color, index)-> AnyPalette.Color.is(reparsed_palette[index], color))
											console.log "Reparsing successful - it's a match!"
										else
											console.log("Reparsed:", [reparsed_palette...].map((color)-> color.toString()))
											console.log("Original:", [palette...].map((color)-> color.toString()))
											console.error "Reparsing failed - colors don't match!"
											process.exit(1)
										result2 = AnyPalette.writePalette(reparsed_palette, format)
										# results may be ArrayBuffer or string
										if result2.toString() isnt result.toString()
											console.error "Saved palette serialized differently when reading back and saving again"
											console.log "Original save:", output_file_path
											output_2_file_path = output_file_path.replace(/\.out/, ".out.2")
											fs.writeFileSync output_2_file_path, result2, "utf8"
											console.log "Second save:", output_2_file_path
											# process.exit(1)
