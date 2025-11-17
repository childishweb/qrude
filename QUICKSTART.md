# QRude Quick Start Guide

## Opening the Project

The Xcode project is now fixed and ready to use. Here's how to get started:

### 1. Open in Xcode
```bash
cd /path/to/qrude
open QRude.xcodeproj
```

### 2. Configure Signing
1. Click on the **QRude** project in the navigator (blue icon at top)
2. Select the **QRude** target under "Targets"
3. Go to the **Signing & Capabilities** tab
4. Select your **Team** from the dropdown
5. Xcode will automatically configure provisioning

**Note:** You need an Apple Developer account (free or paid) to run on a physical device.

### 3. Select Your Device
- For Simulator: Choose any iPhone from the device dropdown (top bar)
- For Physical Device: Connect your iPhone via USB and select it

### 4. Build and Run
- Press **⌘R** (Command + R) or click the Play button
- First build may take a minute
- The app will launch on your device/simulator

## First Run

When you first launch QRude:

1. **Camera Permission**: Tap "Allow" when prompted for camera access
2. **Test Scanning**: Point at any QR code to test
3. **Explore Features**: Try the History, Create, and Settings tabs

## Customization

### Change Bundle Identifier
1. Select the project in Xcode
2. Select the QRude target
3. Go to **General** tab
4. Change **Bundle Identifier** from `com.qrude.app` to your own
   - Example: `com.yourname.qrude`

### Add Your Donation Link
1. Open `QRude/Views/SettingsView.swift`
2. Find line ~48: `"https://buymeacoffee.com/qrude"`
3. Replace with your own Buy Me a Coffee link

### Update GitHub URLs
In `SettingsView.swift`, update these URLs:
- Line ~56: GitHub repository URL
- Line ~62: GitHub issues URL

In `README.md`, update:
- Replace `yourusername` with your GitHub username

## Control Center Setup

To enable quick access from Control Center:

1. **Build and install** the app on your iPhone (not simulator)
2. On your iPhone, go to: **Settings → Control Center**
3. Scroll down to **"More Controls"**
4. Find **"QRude Scanner"** and tap the **+** button
5. To use: Swipe down from top-right (iPhone with Face ID) or swipe up from bottom (iPhone with Touch ID)
6. Tap the QRude icon

**Note:** Control Center widgets only work on physical devices, not in the simulator.

## Project Structure

```
QRude/
├── QRude.xcodeproj/          # Xcode project
├── QRude/                     # Source code
│   ├── QRudeApp.swift        # App entry point
│   ├── AppIntent.swift       # Control Center integration
│   ├── Views/                # All SwiftUI views
│   ├── Models/               # Data models
│   ├── Utilities/            # QR scanner & generator
│   ├── Assets.xcassets/      # App assets
│   └── Info.plist           # App configuration
├── README.md                 # Main documentation
├── SETUP.md                  # Detailed setup guide
├── FEATURES.md              # Feature documentation
└── LICENSE                   # MIT License

```

## Common Issues

### "No Development Team"
- You need to sign in with your Apple ID in Xcode
- Go to: **Xcode → Settings → Accounts**
- Click **+** and add your Apple ID
- Then select it as your team in project settings

### Camera Not Working in Simulator
- Camera scanning only works on **physical devices**
- Use a real iPhone/iPad for testing QR scanning
- The simulator can still test the Create and Settings features

### Build Fails
- Clean build folder: **⌘⇧K** (Command + Shift + K)
- Or: **Product → Clean Build Folder**
- Then build again

### App Crashes on Launch
- Check the deployment target matches your device iOS version
- Go to project settings → **General** → **Deployment Info**
- Should be iOS 15.0 or later

## Testing Checklist

- [ ] App builds without errors
- [ ] Camera permission requests properly
- [ ] QR codes scan successfully
- [ ] History saves and loads
- [ ] QR code generator creates codes
- [ ] Share functionality works
- [ ] Dark mode looks good
- [ ] Settings toggle properly

## What's Included

### Features
- ✅ QR & barcode scanner
- ✅ QR code generator (6 types)
- ✅ Scan history with search
- ✅ Control Center integration
- ✅ Auto-return to scan mode
- ✅ Dark mode support
- ✅ Privacy-focused (local storage only)
- ✅ No ads, no tracking

### Documentation
- ✅ README with features
- ✅ SETUP guide
- ✅ FEATURES documentation
- ✅ CONTRIBUTING guidelines
- ✅ MIT License
- ✅ GitHub templates

## Next Steps

1. **Build the app** and test it
2. **Customize** bundle ID and donation links
3. **Add app icon** to Assets.xcassets/AppIcon.appiconset
4. **Test on device** for full functionality
5. **Submit to App Store** (optional)

## Need Help?

- Check the main [README.md](README.md)
- See detailed [SETUP.md](SETUP.md)
- Review [FEATURES.md](FEATURES.md)
- Create an issue on GitHub

---

**Happy coding! 🎉**

The project is ready to build and run in Xcode.
