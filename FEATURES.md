# QRude Features Documentation

## Core Features

### 1. QR Code Scanning
- **Real-time scanning** using device camera
- **Multiple format support**: QR codes, EAN-8, EAN-13, PDF417, Code 128
- **Haptic feedback** on successful scan (optional)
- **Automatic detection** of content type
- **Debouncing** to prevent duplicate scans

**Supported Content Types:**
- URLs (https://, http://)
- Email addresses (mailto:)
- Phone numbers (tel:)
- SMS messages (sms:, smsto:)
- WiFi credentials (WIFI:)
- Contact information (VCARD, MECARD)
- Plain text

### 2. QR Code Generation
- **Multiple QR types**:
  - Plain Text
  - URLs
  - Email addresses
  - Phone numbers
  - SMS messages
  - WiFi credentials
- **High-quality output** (512x512 pixels)
- **Medium error correction** for reliability
- **Share or save** generated codes
- **Save to Photos** integration

### 3. Scan History
- **Automatic history** of all scanned codes
- **Searchable** by content
- **Swipe actions**:
  - Swipe right: Mark as favorite
  - Swipe left: Delete
- **Smart deduplication**: Recent scans moved to top
- **Limit**: 100 most recent items
- **Persistent storage** using UserDefaults
- **Quick actions**: Copy, open, share
- **Relative timestamps**: "5 mins ago", "Yesterday", etc.

### 4. Control Center Integration
- **Quick launch** from Control Center
- **Siri Shortcuts** integration
- **App Intents** for iOS 16+
- **Phrases**:
  - "Scan a QR code with QRude"
  - "Open QRude scanner"
  - "Scan with QRude"

### 5. Smart Auto-Actions
- **Auto-return to scan mode** after actions
- **Smart link handling**:
  - Preview before opening (default)
  - Auto-open (optional in settings)
- **Clipboard integration**
- **App URL schemes** support

### 6. Settings & Customization

**Scanning Options:**
- Vibration on scan (on/off)
- Keep screen on while scanning (on/off)
- Auto-open links without preview (on/off)

**Support Options:**
- Buy Me a Coffee link
- In-app tips (IAP)
- GitHub repository link
- Issue reporting

**Privacy:**
- Privacy-first disclosure
- No data collection notice
- Local storage only

## User Interface

### Tab Navigation
1. **Scan** (leftmost) - Primary scanning interface
2. **History** (middle) - View past scans
3. **Create** (right) - Generate new QR codes
4. **Settings** (rightmost) - App configuration

### Design Principles
- **Native iOS design** using SwiftUI
- **Dark mode support** throughout
- **Accessibility** with proper labels
- **Haptic feedback** for key actions
- **Clear visual hierarchy**
- **Minimal, focused UI**

## Technical Features

### Privacy & Security
- **Zero data collection**
- **No analytics or tracking**
- **No third-party SDKs**
- **Local-only storage**
- **Open source** for transparency
- **Camera access** only when needed
- **Photo access** only for saving

### Performance
- **Background camera processing** for smooth UI
- **Efficient scanning** with debouncing
- **Lazy loading** of history
- **Optimized QR generation**
- **Low memory footprint**

### Compatibility
- **iOS 15.0+** support
- **iPhone & iPad** optimized
- **Portrait & Landscape** modes
- **Light & Dark** modes
- **Dynamic Type** support
- **Accessibility** features

## Future Features (Roadmap)

### Planned
- [ ] Home Screen widgets
- [ ] Share extension (scan from other apps)
- [ ] Batch scanning mode
- [ ] Custom QR colors and styles
- [ ] History export (CSV, JSON)
- [ ] History categories/folders
- [ ] QR code from image library
- [ ] Advanced QR types (Calendar events, Locations)

### Under Consideration
- [ ] macOS version
- [ ] Apple Watch companion
- [ ] iCloud sync (optional)
- [ ] QR analytics (scanning patterns)
- [ ] Custom URL schemes
- [ ] Shortcuts actions

## Comparison with Other Apps

| Feature | QRude | Others |
|---------|-------|--------|
| Price | Free | Often paid/subscription |
| Ads | None | Usually yes |
| Privacy | Local only | Often track users |
| Open Source | Yes | Rarely |
| Auto-return | Yes | Often no |
| Control Center | Yes | Uncommon |
| History | Unlimited* | Often limited |
| Favorites | Yes | Sometimes |
| Generator | Full-featured | Often basic |

*Limited to 100 most recent items for performance

## Technical Specifications

### Frameworks Used
- **SwiftUI** - Modern UI framework
- **AVFoundation** - Camera and scanning
- **CoreImage** - QR code generation
- **StoreKit** - In-app purchases (optional)
- **AppIntents** - Control Center integration

### Data Storage
- **UserDefaults** for history and preferences
- **JSON encoding** for data persistence
- **No external databases**
- **No cloud services**

### Permissions Required
- **Camera** - For scanning QR codes
- **Photo Library** (Add Only) - For saving generated codes

### Code Quality
- **Swift 5.9+**
- **SwiftUI best practices**
- **MVVM architecture**
- **Modular design**
- **Documented code**
- **Type-safe**

---

**QRude** - Feature-rich, privacy-focused, and completely free.
