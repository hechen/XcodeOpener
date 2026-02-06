# XcodeOpener

A macOS menu bar app to open Xcode projects with your preferred Xcode version.

[![Swift 5.9+](https://img.shields.io/badge/Swift-5.9+-orange.svg)](https://swift.org)
[![macOS 12+](https://img.shields.io/badge/macOS-12+-blue.svg)](https://developer.apple.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## Features

- **Version Selection** - Choose which Xcode opens `.xcodeproj` and `.xcworkspace` files
- **Multiple Xcodes** - Support for multiple Xcode versions installed side-by-side
- **Auto-Detection** - Automatically detects installed Xcode versions
- **Rules Engine** - Define rules for which Xcode handles which file types
- **Menu Bar App** - Runs quietly in the menu bar
- **Launch at Login** - Optional auto-start with macOS

## How It Works

1. XcodeOpener registers itself as the default handler for Xcode project files
2. When you open a `.xcodeproj` or `.xcworkspace`, XcodeOpener intercepts it
3. Based on your rules, it opens the project with your preferred Xcode version

## Installation

1. Download the latest release
2. Move `XcodeOpener.app` to `/Applications`
3. Launch the app
4. Configure your Xcode versions and rules

## Usage

### Adding Xcode Versions

1. Click the XcodeOpener menu bar icon
2. Select "Show Main Window"
3. Go to the "Xcodes" tab
4. Click "+" to add an Xcode installation
5. Give it an alias (e.g., "Xcode 15") and select the app path

### Creating Rules

1. Go to the "Rules" tab
2. Click "+" to add a new rule
3. Select the file type (`.xcodeproj` or `.xcworkspace`)
4. Choose which Xcode should handle it

### Reverting to Default

To restore macOS default behavior:
1. Click the menu bar icon
2. Select "Back to Xcode"

## Technical Details

XcodeOpener uses macOS Launch Services APIs to:
- Register as the default handler for Xcode file types
- Intercept file open requests
- Launch the appropriate Xcode version

```swift
// Register as default handler
LSSetDefaultRoleHandlerForContentType(uti, .all, bundleId)

// Open file with specific app
NSWorkspace.shared.openFile(path, withApplication: xcodePath)
```

## Requirements

- macOS 12.0+
- One or more Xcode installations

## License

MIT License - see [LICENSE](LICENSE) for details.

## Credits

Created by [Chen He](https://github.com/hechen).
Updated in 2026 with modern macOS API support.
