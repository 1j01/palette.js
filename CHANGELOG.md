# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

This project does not adhere to [Semantic Versioning](https://semver.org/spec/v2.0.0.html) yet, since it's pre-1.0.0.

Refer to the [latest version of the changelog](https://github.com/1j01/anypalette.js/blob/master/CHANGELOG.md)
for potential future corrections.
(The changelog can't be retroactively updated within an npm release, so if for instance a breaking change was accidentally omitted, it wouldn't be in the changelog in the release, but it could be added later to the changelog on GitHub.)

[Unreleased]: https://github.com/1j01/anypalette.js/compare/v0.6.0...HEAD
## [Unreleased]
<details>
	<summary>
		Changes in master that are not yet released.
		Click to see more.
	</summary>

### Added
- Dot is now allowed in `fileExt` option (with or without the dot works)

</details>

[0.6.0]: https://github.com/1j01/anypalette.js/compare/v0.5.2...v0.6.0
## [0.6.0] - 2021-01-27
### Changed
- Duplicate colors are included by default now. To get unique colors only, use `AnyPalette.uniqueColors(palette)`
- `color.is(colorB)` is now `Color.is(colorA, colorB)` and does a comparison based on component values instead of the string representation.

### Removed
- `palette.withDuplicates`: Duplicate colors are included by default now.
- (undocumented and silly) `RandomPalette`, `RandomColor`, `gimmeAPalette`
- (undocumented) `palette.loader`, `matchedLoaderFileExtensions`

### Added
- **Support for saving files!**
  Use `var fileContent = AnyPalette.writePalette(palette, AnyPalette.formats.GIMP_PALETTE)` to save a GPL file. Many formats are supported.
- `AnyPalette.uniqueColors(palette)`: Use this to get a version of a palette with only unique colors.
  Note: `numberOfColumns` on the returned palette is undefined, because the geometry doesn't necessarily apply if some colors are removed.
  `name` is however copied over.
- `Color` objects now have `red`, `green`, `blue` properties. The range is `[0,1]`, not `[0,255]`, and they are available even if the input format is HSL or another colorspace.
- Alpha support (translucent colors). `color.alpha` exists only if alpha is defined for a color. This is used for choosing between string representations.
- `loadPalette` callback now gets extra parameters for getting info about the format the file was parsed as.
- You can now pass an `ArrayBuffer` or Node.js `Buffer` as input to `AnyPalette.loadPalette({data}, callback)`. This is preferred over binary strings because it supports Unicode (UTF-8) encoded string names (and it's generally more modern).
- `palette.name` and `palette.description` are now available, for some palette formats.
- Adobe Color Swatch (`.aco`) read and write support
- Adobe Swatch Exchange (`.ase`) read and write support
- sK1 Palette (`.skp`) read and write support
- StarOffice/OpenOffice/LibreOffice palettes (`.soc`) read and write support

### Fixed
- Unicode (UTF-8) is now supported in text-based formats (for color names etc.), **except** when passing in a binary string.
- Dropping of last two colors when reading RIFF `.pal` palette
- Dropping of first color when reading Skencil `.spl` palette

### Deprecated
- Binary string support. Use `ArrayBuffer` or another input type instead.

[0.5.2]: https://github.com/1j01/anypalette.js/compare/v0.5.1...v0.5.2
## [0.5.2] - 2021-01-15
### Fixed
- Adobe Color Table and StarCraft palettes missing last color

[0.5.1]: https://github.com/1j01/anypalette.js/compare/v0.5.0...v0.5.1
## [0.5.1] - 2021-01-14
### Changed
- Adobe Color Table (`.act`) palettes now have `numberOfColumns` defined as `16`. The palette view in Photoshop can be resized, but some palettes, such as Visibone, rely on the default size of 16 columns.

[0.5.0]: https://github.com/1j01/anypalette.js/compare/v0.4.0...v0.5.0
## [0.5.0] - 2020-06-14
### Changed
- Prevented false positive parsing of CSS colors by detecting if a file is binary. (Some binary files would by chance contain things that look like CSS hex colors, such as `#a9e`)
- Prevented false positive parsing of ColorSchemer files by limiting it to when the file extension is `.cs`

### Added
- Adobe Color Table `.act` loader (This very simple format overlaps with the Starcraft palette format, so some `.act` files would already be loaded with the Starcraft loader, but now the name shows up as "Adobe Color Table" instead of "Starcraft palette" in the demo, which is nice.)

[0.4.0]: https://github.com/1j01/anypalette.js/compare/v0.3.0...v0.4.0
## [0.4.0] - 2020-06-12
### Changed
- Renamed `.colors` KDE RGB Palette loader from "KDE RGB palette" to "KolourPaint palette"
- Renamed `.spl` loader from "Sketch RGB palette" to "Skencil palette"
- Renamed `.hpl` loader from "HPL palette" to "Homesite palette"

### Fixed
- Improved error handling

### Added
- Tabular colors loader for various formats that have comma, space, or tab separated RGB values, such as mtPaint's txt palette format
- sK1 `.skp` loader (not very generalized - these files are Python source code as far as I can tell - but supporting RGB, CMYK, Grayscale, and a palette `name`, `description`, and `numberOfColumns`)
- Windows `.theme` and `.themepack` loader

[0.3.0]: https://github.com/1j01/anypalette.js/compare/v0.2.0...v0.3.0
## [0.3.0] - 2020-06-10
### Fixed
- `.gpl` loader: The first line after the "GIMP Palette" line was accidentally skipped, which could lead to missing the first color, or missing the name of the palette, but it's now parsed correctly.

### Changed
- Renamed CSS colors loader "CSS-style colors" -> "CSS colors"
- StarCraft palettes are only loaded if they have certain exact sizes, so that arbitrary files are not parsed as garbage StarCraft palettes

### Added
- `.spl` loader for [Skencil](https://skencil.org/) palettes ("Sketch RGBPalette" - Skencil was formerly called Sketch)
- `.sketchpalette` loader for [Sketch](https://www.sketch.com/) palettes (unrelated to Skencil `.spl` files)
- `.colors` loader for [KolourPaint](https://kde.org/applications/en/graphics/org.kde.kolourpaint) palettes

[0.2.0]: https://github.com/1j01/anypalette.js/compare/v0.1.0...v0.2.0
## [0.2.0] - 2020-06-09
### Changed
- `AnyPalette.load` is now `AnyPalette.loadPalette`; this is so with destructuring you get a clearly named function ("load" would be too generic). (Also, it has the name of the class that it loads, which is a nice bit of self-documentation. It doesn't load an `AnyPalette` (that's the namespace), it loads a `Palette`)
- `n_columns` is now `numberOfColumns`
- (The API is now fully camelCase.)
- (Undocumented property `has_dimensions` is now `geometrySpecifiedByFile`)
- (Undocumented properties `loaded_as` and `loaded_as_clause` are replaced with `loader: {name, fileExtensions, fileExtensionsPretty}` and `matchedLoaderFileExtensions`)

### Added
- More CSS color values can be parsed (functional rgb/rgba/hsl/hsla, including space-separated versions)

[0.1.0]: https://github.com/1j01/anypalette.js/compare/c74f0d93543c4f52ee7c1fd6e6c9201d47b0df33...v0.1.0
## [0.1.0] - 2018-09-21
### Added
- Initial release.
