//
//  MainTabView.swift
//  QRude
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var historyManager: HistoryManager
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            ScanView(selectedTab: $selectedTab)
                .tabItem {
                    Label("Scan", systemImage: "qrcode.viewfinder")
                }
                .tag(0)

            HistoryView()
                .tabItem {
                    Label("History", systemImage: "clock")
                }
                .tag(1)

            CreateView()
                .tabItem {
                    Label("Create", systemImage: "qrcode")
                }
                .tag(2)

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(3)
        }
        .accentColor(.blue)
    }
}
