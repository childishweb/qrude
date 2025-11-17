# QRude Setup Guide

## Quick Start

### Prerequisites
- macOS with Xcode 14.0 or later
- iOS device or simulator running iOS 15.0+
- Apple Developer account (for device deployment)

### Building the App

1. **Clone the Repository**
   ```bash
   git clone https://github.com/yourusername/qrude.git
   cd qrude
   ```

2. **Open in Xcode**
   ```bash
   open QRude.xcodeproj
   ```

3. **Configure Signing**
   - Select the QRude project in the navigator
   - Select the QRude target
   - Go to "Signing & Capabilities"
   - Select your Team from the dropdown
   - Xcode will automatically manage your signing certificates

4. **Build and Run**
   - Select your target device or simulator
   - Press `Cmd + R` or click the Play button
   - The app will build and launch

## Setting Up Control Center Access

To enable quick access from Control Center:

1. **Build and install the app** on your device
2. **On your iPhone**, go to:
   - Settings → Control Center
   - Scroll down to "More Controls"
   - Find "QRude Scanner" and tap the "+" button
3. **To use**: Swipe down from top-right (Face ID) or up from bottom (Home button)
4. **Tap the QRude icon** to instantly open the scanner

## Customization

### Changing the Bundle Identifier

1. Open `QRude.xcodeproj`
2. Select the project in the navigator
3. Select the QRude target
4. In "General" tab, change the Bundle Identifier
5. Update it to match your domain (e.g., `com.yourname.qrude`)

### Adding Your Buy Me a Coffee Link

1. Open `QRude/Views/SettingsView.swift`
2. Find line with `"https://buymeacoffee.com/qrude"`
3. Replace with your own Buy Me a Coffee URL

### Implementing In-App Purchases (Tips)

To add tip jar functionality:

1. **Set up in App Store Connect**:
   - Create a new in-app purchase
   - Type: Consumable
   - Product IDs:
     - `com.yourapp.tip.small`
     - `com.yourapp.tip.medium`
     - `com.yourapp.tip.large`

2. **Implement StoreKit**:
   - Add StoreKit framework
   - Create a StoreManager class
   - Update `SettingsView.swift` to handle purchases

Example tip prices:
- Small: $0.99
- Medium: $2.99
- Large: $4.99

## Project Structure

```
QRude/
├── QRudeApp.swift          # App entry point
├── AppIntent.swift         # Control Center integration
├── Info.plist             # App configuration
├── Views/
│   ├── MainTabView.swift  # Tab navigation
│   ├── ScanView.swift     # QR scanner
│   ├── HistoryView.swift  # Scan history
│   ├── CreateView.swift   # QR generator
│   └── SettingsView.swift # Settings
├── Models/
│   ├── QRCodeItem.swift   # Data model
│   └── HistoryManager.swift # History storage
└── Utilities/
    ├── QRScanner.swift    # Camera scanning
    └── QRGenerator.swift  # QR generation
```

## Testing

### Manual Testing Checklist

- [ ] Camera permission request works
- [ ] QR codes scan successfully
- [ ] Multiple QR code types detected correctly
- [ ] History saves and persists
- [ ] QR code generation works for all types
- [ ] Settings toggle properly
- [ ] Dark mode displays correctly
- [ ] Auto-return to scan mode works
- [ ] Share functionality works
- [ ] Save to photos works

### Testing Different QR Types

Generate test QR codes at: https://www.qr-code-generator.com/

Test these types:
- Plain text
- URLs
- Email addresses
- Phone numbers
- WiFi credentials

## Troubleshooting

### Camera Not Working
- Check Info.plist has `NSCameraUsageDescription`
- Verify camera permissions in Settings → QRude
- Try on a physical device (simulator camera is limited)

### Build Errors
- Clean build folder: `Cmd + Shift + K`
- Delete Derived Data: `Cmd + Shift + Option + K`
- Restart Xcode
- Verify Xcode is up to date

### App Crashes on Launch
- Check deployment target matches your device iOS version
- Verify all required frameworks are linked
- Check console logs in Xcode

## Deployment

### TestFlight

1. Archive the app: Product → Archive
2. Distribute to App Store Connect
3. Add to TestFlight
4. Invite testers via email

### App Store

1. Create app in App Store Connect
2. Fill in all metadata
3. Submit for review
4. Wait for approval (typically 1-3 days)

## Privacy & Permissions

QRude requests these permissions:

- **Camera**: Required for scanning QR codes
- **Photo Library**: Optional, only for saving generated QR codes

Both are requested only when needed, with clear explanations.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development guidelines.

## Support

- Issues: [GitHub Issues](https://github.com/yourusername/qrude/issues)
- Discussions: [GitHub Discussions](https://github.com/yourusername/qrude/discussions)

---

Happy scanning! 📱✨
