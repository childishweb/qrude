//
//  QRudeApp.swift
//  QRude - Free & Open Source QR Code Scanner and Generator
//
//  Created with Swift and SwiftUI
//

import SwiftUI

@main
struct QRudeApp: App {
    @StateObject private var historyManager = HistoryManager()

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(historyManager)
        }
    }
}
