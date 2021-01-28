
# <img src="anypalette-logo.png" height="32" alt=""> AnyPalette.js

There are a LOT of different types of palette files.
Like, way too many.
But we can solve this.

```
One library to rule them all,
   one library to find them,
One library to load them all
   and in the browser bind them. 
```

[Check out the demo!](https://1j01.github.io/anypalette.js/demo)


## Features

AnyPalette.js has a single interface for all formats, so you can load any of the supported file types with one call,
and it'll choose an appropriate parser to use automatically.

It can even load from files that aren't intended specifically as palettes, but that have CSS-style color values in them (.css, .html, .svg, .js, etc.)

Works in Node.js and in the browser.

Supported palette formats:

| File Extension    | Name                              | Programs                                                                          |   Read  |  Write  |
|-------------------|-----------------------------------|-----------------------------------------------------------------------------------|:-------:|:-------:|
| .pal              | [RIFF] Palette                    | [MS Paint] for Windows 95 and Windows NT 4.0                                      |   ✅   |   ✅    |
| .gpl              | [GIMP][Gimp] Palette              | [Gimp], [Inkscape], [Krita], [KolourPaint], [Scribus], [CinePaint], [MyPaint]     |   ✅   |   ✅    |
| .aco              | Adobe Color Swatch                | Adobe [Photoshop]                                                                 |   ✅   |   ✅    |
| .ase              | Adobe Swatch Exchange             | Adobe [Photoshop], [InDesign], and [Illustrator]                                  |   ✅   |   ✅    |
| .txt              | [Paint.NET] Palette               | [Paint.NET]                                                                       |   ✅   |   ✅    |
| .act              | Adobe Color Table                 | Adobe [Photoshop] and [Illustrator]                                               |   ✅\* |   ✅    |
| .pal, .psppalette | [Paint Shop Pro] Palette          | [Paint Shop Pro] (Jasc Software / Corel)                                          |   ✅   |   ✅    |
| .hpl              | [Homesite] Palette                | Allaire [Homesite] / Macromedia [ColdFusion]                                      |   ✅   |   ✅    |
| .cs               | ColorSchemer                      | ColorSchemer Studio                                                               |   ✅\* |         |
| .pal              | [Starcraft] Palette               | [Starcraft]                                                                       |   ✅   |   ✅    |
| .wpe              | [Starcraft] Terrain Palette       | [Starcraft]                                                                       |   ✅   |   ✅    |
| .sketchpalette    | [Sketch] Palette                  | [Sketch]                                                                          |   ✅   |   ✅    |
| .spl              | [Skencil] Palette                 | [Skencil] (formerly called Sketch)                                                |   ✅   |   ✅    |
| .soc              | StarOffice Colors                 | [StarOffice], [OpenOffice], [LibreOffice]                                         |   ✅   |   ✅    |
| .colors           | KolourPaint Color Collection      | [KolourPaint]                                                                     |   ✅   |   ✅    |
| .colors           | Plasma Desktop Color Scheme       | [KDE] Plasma Desktop                                                              |   ✅   |         |
| .theme            | Windows Theme                     | [Windows] Desktop                                                                 |   ✅   |         |
| .themepack        | Windows Theme                     | [Windows] Desktop                                                                 |   ✅   |         |
| .css, .scss, .styl| Cascading StyleSheets             | Web browsers / web pages                                                          |   ✅   |   ✅    |
| .html, .svg, .js  | any text files with CSS colors    | Web browsers / web pages                                                          |   ✅   |         |

\*The ColorSchemer file parser is only enabled when the file extension is known to be `.cs`,
provided by passing a `File` object, or `options.fileName`, or `options.fileExt`, or `options.filePath`.
The Adobe Color Table loader is only enabled when the file extension is known to be `.act` OR the file is exactly 768 or 772 bytes long.

UNSUPPORTED palette formats (for now):

| File Extension    | Name                              | Programs                                                                          |   Read  |  Write  |
|-------------------|-----------------------------------|-----------------------------------------------------------------------------------|:-------:|:-------:|
| .gpa              | [Gpick] Palette                   | [Gpick]                                                                           |         |         |
| .acb              | Adobe Color Book                  | Adobe [InDesign] and [Illustrator]                                                | ✅\*\*  |         |
| .acbl             | Adobe Color Book Library / Legacy | Adobe [InDesign] and [Illustrator] (?)                                            |         |         |

\*\*None of the color spaces are supported (CMYK, CIELAB, CIEXYZ). The code is mostly all there! But I think probably *ICC profiles* are needed for correct-looking colors.

[RIFF]: https://en.wikipedia.org/wiki/Resource_Interchange_File_Format
[MS Paint]: https://en.wikipedia.org/wiki/Microsoft_Paint
[Paint.NET]: https://www.getpaint.net/
[Paint Shop Pro]: https://www.paintshoppro.com/en/
[Starcraft]: https://en.wikipedia.org/wiki/StarCraft
[Homesite]: https://en.wikipedia.org/wiki/Macromedia_HomeSite
[ColdFusion]: https://en.wikipedia.org/wiki/Adobe_ColdFusion
[StarOffice]: https://en.wikipedia.org/wiki/StarOffice
[OpenOffice]: https://www.openoffice.org/
[LibreOffice]: https://www.libreoffice.org/
[Sketch]: https://www.sketchapp.com/
[Skencil]: https://skencil.org/
[Gpick]: http://www.gpick.org/
[Photoshop]: https://www.adobe.com/products/photoshop.html
[InDesign]: https://www.adobe.com/products/indesign.html
[Illustrator]: https://www.adobe.com/products/illustrator.html
[Gimp]: https://www.gimp.org/
[Inkscape]: https://inkscape.org/en/
[Krita]: https://www.calligra.org/krita/
[KolourPaint]: http://kolourpaint.org/
[KDE]: https://kde.org/
[Windows]: https://en.wikipedia.org/wiki/Microsoft_Windows
[Scribus]: https://www.scribus.net/
[CinePaint]: http://www.cinepaint.org/
[MyPaint]: http://mypaint.org/
[Blender]: https://www.blender.org/


Picking colors from an image can be done by other libraries, like [vibrant.js]/[node-vibrant]

[vibrant.js]: https://jariz.github.io/vibrant.js/
[node-vibrant]: https://github.com/akfish/node-vibrant


## License

MIT-licensed, see [LICENSE](LICENSE)


## Install

For Node.js / Webpack / Parcel / Rollup / Browserify, install with:
```sh
npm i anypalette --save
# or
yarn add anypalette
```

Then access the library with:
```js
const AnyPalette = require("anypalette");
```

**Alternatively**, download [`build/anypalette-0.6.0.js`](build/anypalette-0.6.0.js) and include it as a script:

```html
<script src="anypalette-0.6.0.js"></script>
```

This will create a global `AnyPalette`

This library uses UMD, so you can also load it with AMD or CommonJS (in which case it won't create a global).


## API

See the [changelog](CHANGELOG.md) for upgrading.
Properties and methods not documented here may break without notice.

### `AnyPalette.loadPalette(options, callback)`

Load a palette from a palette file.
You can pass in the file data in a few different ways.

Knowing the file extension means AnyPalette.js can often pick the correct palette loader right away, which can improve the load speed, and also a few loaders are only enabled if their specific file extension matches because they can't determine if the file is actually in that format or not (for raw data formats without headers).

- `options.file` - the palette file to load, as a [`File`](https://developer.mozilla.org/en-US/docs/Web/API/File)
- `options.data` - the palette file data to load, as a binary string or [`ArrayBuffer`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/ArrayBuffer) or Node.js [`Buffer`](https://nodejs.org/api/buffer.html#buffer_class_buffer) or [`Uint8Array`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Uint8Array) (but **not** any other `TypedArray` or `DataView`). In the case of a binary string, Unicode names for colors do not work, so an `ArrayBuffer` is preferred.
- `options.filePath` - a path to a palette file, for Node.js usage
- `options.fileName` (optional) - the file name, if you have it, including the file extension - can be obtained automatically from `options.file` or `options.filePath`
- `options.fileExt` (optional) - the file extension, if you have it, with or without the dot, e.g. `"pal"` - can be obtained automatically from `options.fileName` or `options.file` or `options.filePath`
- `callback(error, palette, formatUsed, matchedFileExtension)` (required) - called when palette loading is finished, either with an error (in the first argument) or with the remaining arguments in the case of success:
	- `palette`: a [`Palette`](#class-palette-extends-array)
	- `formatUsed`: a [`Format`](#class-format) object representing the file format, or more generic loader, that was used to parse the palette
	- `matchedFileExtension`: whether the format matched one of the file extensions its known for (Boolean)

> **Note**: The callback is actually executed synchronously if you pass data directly. It's in an asynchronous style to allow for file loading, but all the palette parsing is currently synchronous. TODO: `setImmediate` at least.

### `AnyPalette.loadPalette(file, callback)`

Shortcut to load from a [`File`](https://developer.mozilla.org/en-US/docs/Web/API/File) object, equivalent to passing `{file: file}` for `options`.

### `AnyPalette.loadPalette(filePath, callback)`

Shortcut to load from a file path in Node.js,  equivalent to passing `{filePath: filePath}` for `options`.

### `AnyPalette.writePalette(palette, format)`

Returns string (for text-based formats) or `ArrayBuffer` (for binary formats) of the content of a file, in the given [`Format`](#class-format).

To save a palette as a GPL file, sending a download in a browser:

```js
var format = AnyPalette.formats.GIMP_PALETTE;
var file_content = AnyPalette.writePalette(palette, format);
var file = new File([file_content], "Saved Colors.gpl");
var url = URL.createObjectURL(file);
var a = document.createElement("a");
a.href = url;
a.download = file.name;
document.body.appendChild(a);
a.click(); // Note: this must happen during a user gesture to work
document.body.removeChild(a);
```

If you don't know what format to export as, use `GIMP_PALETTE` (`.gpl`), as it's supported by a wide range of software.

#### `AnyPalette.uniqueColors(palette)`

Some palette formats are commonly made variable size by just leaving unused slots a certain color
such as `#000` or `#00F`.
You can get a [`Palette`](#class-palette-extends-array) with only unique colors like so:
```js
var withoutDuplicates = AnyPalette.uniqueColors(palette);
```

### class `Palette` extends `Array`

(Accessible as `AnyPalette.Palette`)


Stores a list of [`Color`](#class-color)s, and some metadata.

Because `Palette` is a subclass of `Array`, you can use `forEach`, `map`, `join` and other methods,
or access the colors via indexing e.g. `palette[0]` and loop over them using `palette.length`

> **Note**: I think this was a bad design decision because `map` unintuitively returns an instance of the subclass `Palette`, and `Palette` is only intended to hold `Color`s.
I plan to change it to simply use a `colors` field.  
I could make it an array-*like* object, but that might introduce other confusions. I don't know, jQuery does it. And a bunch of browser-native objects are array-like instead of proper arrays. Maybe that's the way to go.

#### `palette.numberOfColumns`

`palette.numberOfColumns` may contain a number of columns for the palette to fit into (with the number of rows being implicit).  
You should ignore a `numberOfColumns` of zero or `undefined`, and MAY want to ignore this property entirely.
Inkscape, for example, ignores the number of columns specified in a palette.

#### `palette.name`

`palette.name` may contain a name for the palette (as a string), or else `undefined`.

This is **not** populated with the filename, it's only available for palette formats that allow defining a name *within* the file.

#### `palette.description`

`palette.description` may contain a description for the palette (as a string), or else `undefined`.

### class `Color`

(Accessible as `AnyPalette.Color`)


`Color` has a `toString` method that returns a CSS color, which means you can
pass a Color object directly to an element's style or a canvas's context.

```js
var color = palette[0];
div.style.background = color;
ctx.fillStyle = color;
```

See [*Using JavaScript's 'toString' Method*](http://adripofjavascript.com/blog/drips/using-javascripts-tostring-method.html), which incidentally uses a `Color` class as an example.

In some cases you may need to call `toString()` explicitly to get a string, for example:

```js
var shortenedColorString = color.toString().replace(/\s/g, "");
```

`Color` objects also have `red`, `green`, `blue` properties, and **depending on how they were loaded**, might have `hue`, `saturation`, `lightness`, and/or `alpha`.


#### `color.name`

`color.name` may contain a name for the color (as a string), or else `undefined`.

Not all palette formats support named colors.

### `Color.is(colorA, colorB, epsilon=0.0001)`

Determines whether two colors are equal in value, or nearly equal.
```js
var firstTwoColorsExactlyEqual = AnyPalette.Color.is(palette[0], palette[1], 0);
var firstTwoColorsBasicallyEqual = AnyPalette.Color.is(palette[0], palette[1], 0.001);
var firstTwoColorsSimilar = AnyPalette.Color.is(palette[0], palette[1], 20);
```
> **Note**: If you want to find perceptually similar colors, it's better to use CIELAB color space instead of RGB.
This function compares in RGB space and is really only meant for finding duplicates.

### class `Format`

This class represents a loader and/or writer.

- `name`: A friendly name for the format, e.g. `"Paint Shop Pro palette"`
- `fileExtensions`: An array of associated file extensions, without the dot, e.g. `["pal", "psppalette"]`
- `fileExtensionsPretty`: A textual representation of the file extensions, including the dots, e.g. `".pal, .psppalette"`
- `readFromText`: This exists on text-based readers. Don't use it directly, use `AnyPalette.loadPalette` instead.
- `read`: This exists on binary readers. Don't use it directly, use `AnyPalette.loadPalette` instead.
- `write`: This exists on writers. Don't use it directly, use `AnyPalette.writePalette` instead.

### `AnyPalette.formats`

This is an object that contains [`Format`](#class-format) objects, keyed by format IDs.

To get an array of formats:
```js
const formats = Object.values(AnyPalette.formats);
```

To get just writers:
```js
const writeFormats = Object.values(AnyPalette.formats).filter((format)=> format.write);
```

To get just readers:
```js
const readFormats = Object.values(AnyPalette.formats).filter((format)=> format.read || format.readFromText);
```

## Todo


* Load *all the palettes!*
	* Magica Voxel Palette (`.png`) - see [MagicaVoxelPalettes](https://github.com/mattperrin/MagicaVoxelPalettes) for examples
	* macOS Color Palette (`.clr`)
	* Gpick Palette (`.gpa`)
	* Low priority
		* ASCII Color Format (`.acf`)
		* Binary Color Format (`.bcf`)
		* Alias/WaveFront Material (`.mtl`)
		* XML-based:
			* Adobe Color Book Legacy (`.acbl`)
			* AutoCAD Color Book (`.acb`)
			* QuarkXPress Color Library (`.qcl`)
			* Scribus (`.xml`)
			* sK1 (`.skpx` / `.skp`)


* Guess palette geometries?

* More stuff (I have an external TODO list)


## Contributing

### Development Setup

* Install Node.js, if you don't already have it. (It comes with `npm`)

* [Fork and clone](https://help.github.com/articles/fork-a-repo/) the repository

* The repo has a git submodule, so in the repository folder run `git submodule update --init`

* Install dependencies with `npm install`

### Development Workflow

`npm start` will start a server and open a page in your default browser;
it'll rebuild the library when changes to the source files are detected, and it'll auto-reload the page

Run `npm test` to update a `regression-data` folder, and then view any changes with git.  
- If the changes are good/positive, great! Commit the changes along with the source code, or in a separate "Accept" commit.
- If the changes are bad/negative, try to fix the regression.
- `*.out.2.*` files are for files that are saved differently when loading a saved file. Ideally we want none of these.
- If many files are deleted, check the console output. There are some test cases where it will exit early.

Update [CHANGELOG.md](CHANGELOG.md)'s [Unreleased] section with any notable changes,
following the [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) format.
Include any information someone upgrading the library might need to know.

When pulling changes (e.g. syncing a fork) you may need to `npm install` again to update the dependencies.

### To cut a release

The process is currently something like this:

- In [CHANGELOG.md](CHANGELOG.md), replace the [Unreleased] section with the next version.
- Make sure all the numbers are right. There's five version numbers and a date to update.

(TODO: use [update-changelog](https://github.com/ukatama/update-changelog) (altho it doesn't support links to commit ranges... [this does, but it's for a different ecosystem](https://github.com/pajapro/fastlane-plugin-changelog)))

	npm run build
	npm test
	git diff tests/ # there shouldn't be changes to the test data at this point, that should ideally happen in earlier commits
	git add -A && git commit -m "Update for release"
	npm version minor # or major or patch or a specific version number
	git push --follow-tags # better than --tags!
	npm publish
