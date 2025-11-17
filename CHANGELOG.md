# Changelog

All notable changes to QRude will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-11-17

### Added
- Initial release of QRude
- QR code and barcode scanning with camera
- Support for multiple formats: QR, EAN-8, EAN-13, PDF417, Code 128
- Automatic content type detection (URL, email, phone, SMS, WiFi, contact, text)
- QR code generator with multiple types:
  - Plain text
  - URLs
  - Email addresses
  - Phone numbers
  - SMS messages
  - WiFi credentials
- Scan history with search functionality
- Swipe gestures for history management (favorite/delete)
- Control Center integration for quick access
- App Intents and Siri Shortcuts support
- Settings page with customization options:
  - Vibration toggle
  - Keep screen on while scanning
  - Auto-open links
- Donation support via Buy Me a Coffee
- In-app purchase tip jar support
- Auto-return to scan mode after actions
- Dark mode support
- Privacy-first approach (no data collection)
- Share and save generated QR codes
- Haptic feedback on successful scans
- MIT License - fully open source

### Security
- Camera access requested only when needed
- Photo library access only for saving QR codes
- All data stored locally on device
- No analytics or tracking
- No third-party SDKs

## [Unreleased]

### Planned for 1.1.0
- Home Screen widgets
- Share extension support
- QR code scanning from photo library
- Batch scanning mode
- Custom QR code colors
- History export (CSV/JSON)
- Accessibility improvements

### Under Consideration
- macOS version
- Apple Watch companion app
- iCloud sync (optional)
- Advanced QR types (Calendar, Location)
- Custom URL schemes
- Additional Shortcuts actions

---

## Version History

### Version Numbering
- **Major.Minor.Patch**
- Major: Breaking changes or major new features
- Minor: New features, backwards compatible
- Patch: Bug fixes and minor improvements

### Release Notes
Each release includes:
- Feature additions
- Bug fixes
- Performance improvements
- Security updates
- Breaking changes (if any)

---

For more details on each release, see the [Releases](https://github.com/yourusername/qrude/releases) page.
