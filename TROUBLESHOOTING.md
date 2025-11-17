# Troubleshooting QRude

## Project Won't Open in Xcode

### "Project is damaged" or "No build configurations" Error

**Fixed in latest version!** The project file has been completely rebuilt with proper structure.

If you still encounter issues:

1. **Pull the latest changes:**
   ```bash
   cd ~/qrude
   git pull origin claude/qr-code-reader-writer-01Pgz2hFLRG54Fjd1B7QKMBH
   ```

2. **Try opening directly:**
   ```bash
   open QRude.xcodeproj
   ```

3. **If it still fails, verify project structure:**
   ```bash
   # Check project file exists
   ls -la QRude.xcodeproj/project.pbxproj

   # Check workspace exists
   ls -la QRude.xcodeproj/project.xcworkspace/

   # Check all Swift files are present
   find QRude -name "*.swift"
   ```

Expected output:
- 11 Swift files
- project.pbxproj file (should be ~17-18KB)
- project.xcworkspace directory

## Build Issues

### "No Such Module" Errors

All required frameworks (SwiftUI, AVFoundation, CoreImage) are part of iOS SDK. No external dependencies needed.

**Fix:**
1. Clean build folder: `⌘⇧K`
2. Rebuild: `⌘B`

### Signing Issues

**Error:** "No Development Team Selected"

**Fix:**
1. Open Xcode → Settings → Accounts
2. Add your Apple ID
3. In project settings → Signing & Capabilities
4. Select your team from dropdown

### "Could not find developer disk image"

Your Mac's Xcode doesn't have support for your iPhone's iOS version.

**Fix:**
- Update Xcode to the latest version
- Or update your iPhone to match your Xcode version

## Runtime Issues

### Camera Not Working

**Symptom:** Black screen or no camera preview

**Causes & Fixes:**

1. **Testing on Simulator:**
   - Camera scanning requires a physical device
   - Simulator doesn't support camera scanning
   - Use a real iPhone/iPad

2. **Permission Denied:**
   - Go to Settings → QRude → Camera
   - Enable camera access

3. **Info.plist Missing:**
   - Verify `NSCameraUsageDescription` exists in Info.plist
   - Should say: "QRude needs camera access to scan QR codes and barcodes."

### App Crashes on Launch

**Check Console Logs:**
1. Window → Devices and Simulators
2. Select your device
3. Click "Open Console"
4. Look for crash logs

**Common Causes:**

1. **iOS Version Mismatch:**
   - Project targets iOS 15.0+
   - Check your device iOS version
   - Update deployment target if needed

2. **Missing Assets:**
   - Verify Assets.xcassets exists
   - Should contain AppIcon and AccentColor

### History Not Saving

**Symptom:** Scanned codes disappear after closing app

**Check:**
- App has write permissions
- UserDefaults is working (no app container issues)
- Not testing on Simulator with "Erase All Content"

**Fix:**
- Reinstall the app
- Test on a physical device

## Control Center Issues

### QRude Not Appearing in Control Center

**Requirements:**
- Must be installed on **physical device** (not simulator)
- Requires iOS 16.0+ for App Intents

**Fix:**
1. Verify app is installed on device
2. Go to Settings → Control Center
3. Scroll to "More Controls"
4. Look for "QRude Scanner"
5. Tap **+** to add it

If still not appearing:
- App Intents require iOS 16+
- Check AppIntent.swift is included in build
- Rebuild and reinstall

### Control Center Widget Doesn't Launch App

**Symptoms:**
- Tapping widget does nothing
- App doesn't open

**Fix:**
- Uninstall and reinstall the app
- Check app isn't restricted in Screen Time
- Verify app can launch normally

## Photo Library Issues

### Can't Save QR Codes

**Error:** "Access Denied" when saving

**Fix:**
1. Settings → QRude → Photos
2. Select "Add Photos Only" or "All Photos"

**Verify Permission String:**
- Check Info.plist has `NSPhotoLibraryAddUsageDescription`

## Performance Issues

### Slow Scanning

**Causes:**
- Low light conditions
- Dirty camera lens
- QR code too small or far away

**Tips:**
- Use in well-lit environment
- Hold device 6-12 inches from QR code
- Ensure QR code is in focus

### App Slow or Laggy

**Fixes:**
1. Close other apps
2. Restart device
3. Clear history (Settings → Clear History)
4. Reinstall app

## Development Issues

### SwiftUI Preview Not Working

**Error:** "Cannot preview in this file"

**Common Causes:**
- Build errors in other files
- Xcode caching issues

**Fixes:**
```bash
# Clean derived data
rm -rf ~/Library/Developer/Xcode/DerivedData/

# Clean build folder in Xcode
⌘⇧K

# Restart Xcode
```

### Git Issues

**Error:** "Failed to push"

**Fix:**
```bash
git pull --rebase
git push
```

**Error:** "Permission denied"

Check your GitHub credentials are configured.

## Still Having Issues?

### Getting Help

1. **Check existing documentation:**
   - README.md
   - SETUP.md
   - QUICKSTART.md
   - FEATURES.md

2. **Review code:**
   - All code is open source
   - Check the implementation
   - Look for TODO comments

3. **File an issue:**
   - Go to GitHub Issues
   - Provide:
     - iOS version
     - Xcode version
     - Device model
     - Steps to reproduce
     - Error messages/screenshots

### Debugging Tips

**Enable more verbose logging:**
- Add `print()` statements in code
- Check Xcode console output
- Use breakpoints to inspect state

**Common locations to check:**
- `ScanView.swift:113` - Scanner code handling
- `HistoryManager.swift:26` - History persistence
- `QRScanner.swift:22` - Camera delegate

**Verify app state:**
```swift
// Add to any view
.onAppear {
    print("DEBUG: View appeared")
    print("DEBUG: History count: \(historyManager.items.count)")
}
```

## Reset Everything

If all else fails:

```bash
# Delete derived data
rm -rf ~/Library/Developer/Xcode/DerivedData/*

# Clean project
cd ~/qrude
git clean -fdx
git pull

# Open fresh
open QRude.xcodeproj
```

Then:
1. Clean build folder in Xcode (`⌘⇧K`)
2. Delete app from device/simulator
3. Build and run fresh

---

**Project Structure Verified:**
- ✅ 11 Swift source files
- ✅ Valid Xcode project file
- ✅ Complete workspace configuration
- ✅ All required assets
- ✅ Proper Info.plist

If you're still experiencing the "damaged project" error after pulling the latest changes, please create a GitHub issue with:
- Your macOS version
- Your Xcode version
- The exact error message
- Output of `ls -R QRude.xcodeproj/`
