# QRude 📱

**A goddamn free and open-source QR code scanner and generator for iOS**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-iOS%2015.0%2B-lightgrey.svg)](https://www.apple.com/ios/)
[![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)](https://swift.org)

## Features ✨

- **Fast QR Code Scanning**: Instantly scan QR codes and barcodes with your camera
- **QR Code Generator**: Create QR codes for URLs, text, WiFi credentials, emails, phone numbers, and SMS
- **Scan History**: Keep track of all your scanned codes with searchable history
- **Control Center Access**: Launch directly from Control Center (swipe from top right on iPhone)
- **Auto-Return to Scan**: Automatically returns to scan mode after taking an action
- **Privacy First**: All data stays on your device - nothing is collected or transmitted
- **No Ads**: Completely free with optional donation support
- **Dark Mode Support**: Fully supports iOS dark mode
- **Multiple Code Types**: Supports QR codes, EAN-8, EAN-13, PDF417, and Code 128

## Why QRude? 🤔

Because every other QR code app either:
- Bombards you with ads
- Requires a subscription
- Tracks your data
- Has a confusing interface

QRude is different. It's **free**, **open source**, and **privacy-focused**.

## Screenshots 📸

*(Screenshots would go here when the app is built)*

## Installation 🚀

### Requirements
- iOS 15.0 or later
- Xcode 14.0 or later
- Swift 5.9 or later

### Building from Source

1. Clone the repository:
```bash
git clone https://github.com/yourusername/qrude.git
cd qrude
```

2. Open the project in Xcode:
```bash
open QRude.xcodeproj
```

3. Select your development team in the project settings

4. Build and run on your device or simulator

### App Store

*(Coming soon - pending App Store submission)*

## Usage 📖

### Scanning QR Codes

1. Open QRude
2. Point your camera at a QR code
3. The code will be automatically detected and scanned
4. Take action (open link, copy text, etc.)
5. The app automatically returns to scan mode for the next code

### Creating QR Codes

1. Tap the "Create" tab
2. Select the type of QR code you want to create
3. Enter your content
4. Tap "Generate QR Code"
5. Save or share your QR code

### Control Center Quick Access

1. Go to Settings > Control Center
2. Add "QRude Scanner" to your controls
3. Swipe down from the top-right corner (iPhone with Face ID) or swipe up from the bottom (iPhone with Home button)
4. Tap the QRude icon to instantly start scanning

## Settings ⚙️

- **Vibration on Scan**: Toggle haptic feedback when a code is scanned
- **Keep Screen On**: Prevent screen from sleeping while scanning
- **Auto-Open Links**: Automatically open URLs without showing preview

## Support Development ❤️

QRude is free and always will be. If you find it useful, consider supporting development:

- [Buy Me a Coffee](https://buymeacoffee.com/qrude)
- In-app tips (via App Store)

## Privacy 🔒

QRude takes your privacy seriously:

- **No data collection**: We don't collect, store, or transmit any of your data
- **No analytics**: No tracking or analytics of any kind
- **No ads**: No ad networks or third-party SDKs
- **Local storage only**: All scan history is stored locally on your device
- **Open source**: You can verify everything in the source code

## Contributing 🤝

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Roadmap 🗺️

- [ ] Widget support for iOS Home Screen
- [ ] iPad optimization
- [ ] Batch scanning mode
- [ ] Custom QR code colors
- [ ] Export history to CSV
- [ ] Shortcuts app integration
- [ ] macOS version

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments 🙏

- Built with SwiftUI and AVFoundation
- Uses Apple's Core Image framework for QR code generation
- Inspired by the need for a simple, privacy-focused QR code app

## Contact 📬

- Report bugs: [GitHub Issues](https://github.com/yourusername/qrude/issues)
- Feature requests: [GitHub Discussions](https://github.com/yourusername/qrude/discussions)

---

**Made with ❤️ for the iOS community**

*QRude - Because scanning QR codes shouldn't be complicated*
