skadi is a lightweight image viewer for OS X. 

It can jump to a previous/next file in a directory, similar to Windows' default image viewer.

![screenshot](screenshot.png)

skadi supports all image formats supported by Qt, this covers most of the popular formats: BMP, GIF, JPEG, PNG, WebP, SVG, TGA, TIFF, WBMP and others.

# Installation

Download the latest version from https://github.com/redcapital/skadi/releases, unpack and move into `~/Applications`.

If you use Homebrew Cask, installation is as simple as running `brew cask install skadi`.

# Building release version

There are some steps to be done to ensure QML files can be found and loaded. Assuming Qt will be installed in `~/qt` and build folder is `~/skadi`.

- Install Qt >= 5.5. Use the installer from the official website, Homebrew version had some problems with `macdeployqt`.
- Open `skadi.pro` in Qt Creator. Choose Release and build.
- Go to `~/qt/clang_64/` and copy the `qml` folder into `~/skadi/skadi.app/Contents/Resources/`.
- Open the terminal, cd to the build folder and run `~/qt/clang_64/bin/macdeployqt skadi.app/`
- Now you should be able to launch the app by running `./skadi.app/Contents/MacOS/skadi`
