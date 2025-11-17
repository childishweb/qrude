//
//  AppIntent.swift
//  QRude
//
//  App Intents for Control Center and Shortcuts
//

import AppIntents
import SwiftUI

@available(iOS 16.0, *)
struct OpenScannerIntent: AppIntent {
    static var title: LocalizedStringResource = "Scan QR Code"
    static var description = IntentDescription("Quickly open QRude to scan a QR code")
    static var openAppWhenRun: Bool = true

    @MainActor
    func perform() async throws -> some IntentResult {
        // This will open the app directly to the scan view
        return .result()
    }
}

@available(iOS 16.0, *)
struct QRudeAppShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: OpenScannerIntent(),
            phrases: [
                "Scan a QR code with \(.applicationName)",
                "Open \(.applicationName) scanner",
                "Scan with \(.applicationName)"
            ],
            shortTitle: "Scan QR Code",
            systemImageName: "qrcode.viewfinder"
        )
    }
}
