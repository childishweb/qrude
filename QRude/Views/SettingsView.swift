//
//  SettingsView.swift
//  QRude
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    @AppStorage("vibrationEnabled") private var vibrationEnabled = true
    @AppStorage("keepScreenOn") private var keepScreenOn = false
    @AppStorage("autoOpenLinks") private var autoOpenLinks = false
    @State private var showingAbout = false

    var body: some View {
        NavigationView {
            List {
                // Scanning Settings
                Section {
                    Toggle("Vibration on Scan", isOn: $vibrationEnabled)
                    Toggle("Keep Screen On While Scanning", isOn: $keepScreenOn)
                    Toggle("Auto-Open Links (Skip Preview)", isOn: $autoOpenLinks)
                } header: {
                    Text("Scanning")
                } footer: {
                    Text("Auto-open will immediately open links after scanning without showing a preview.")
                }

                // Support Section
                Section {
                    Button {
                        if let url = URL(string: "https://buymeacoffee.com/qrude") {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        HStack {
                            Image(systemName: "cup.and.saucer.fill")
                                .foregroundColor(.orange)
                            Text("Buy Me a Coffee")
                            Spacer()
                            Image(systemName: "arrow.up.right")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }

                    Button {
                        requestTip()
                    } label: {
                        HStack {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.pink)
                            Text("Leave a Tip")
                            Spacer()
                            Image(systemName: "dollarsign.circle")
                                .foregroundColor(.secondary)
                        }
                    }
                } header: {
                    Text("Support Development")
                } footer: {
                    Text("QRude is free and open source. Your support helps keep it that way!")
                }

                // About Section
                Section {
                    Button {
                        showingAbout = true
                    } label: {
                        HStack {
                            Image(systemName: "info.circle")
                            Text("About QRude")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }

                    Link(destination: URL(string: "https://github.com/yourusername/qrude")!) {
                        HStack {
                            Image(systemName: "chevron.left.forwardslash.chevron.right")
                            Text("Source Code")
                            Spacer()
                            Image(systemName: "arrow.up.right")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }

                    Button {
                        if let url = URL(string: "https://github.com/yourusername/qrude/issues") {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        HStack {
                            Image(systemName: "exclamationmark.bubble")
                            Text("Report an Issue")
                            Spacer()
                            Image(systemName: "arrow.up.right")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }

                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                } header: {
                    Text("About")
                }

                // Privacy Section
                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "lock.shield.fill")
                                .foregroundColor(.green)
                            Text("Privacy First")
                                .fontWeight(.semibold)
                        }
                        Text("QRude does not collect, store, or transmit any of your data. All scanning history is stored locally on your device only.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Settings")
            .sheet(isPresented: $showingAbout) {
                AboutView(isPresented: $showingAbout)
            }
        }
    }

    private func requestTip() {
        // In-App Purchase tip jar
        // You would implement StoreKit 2 here with tip products
        // For now, we'll show a placeholder alert
        Task {
            do {
                // This is where you'd trigger StoreKit tip products
                // Example product IDs: "com.qrude.tip.small", "com.qrude.tip.medium", "com.qrude.tip.large"
                displayTipOptions()
            }
        }
    }

    private func displayTipOptions() {
        // This would present tip options using StoreKit 2
        // For the complete implementation, you'd need to:
        // 1. Set up App Store Connect with tip products
        // 2. Implement StoreKit 2 Product requests
        // 3. Handle purchase flow
    }
}

struct AboutView: View {
    @Binding var isPresented: Bool

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // App Icon Placeholder
                    Image(systemName: "qrcode.viewfinder")
                        .font(.system(size: 100))
                        .foregroundColor(.blue)
                        .padding(.top, 40)

                    VStack(spacing: 8) {
                        Text("QRude")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Text("Free & Open Source QR Scanner")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        Text("Version 1.0.0")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    Divider()
                        .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 16) {
                        FeatureRow(icon: "qrcode.viewfinder", title: "Fast Scanning", description: "Quickly scan any QR code or barcode")
                        FeatureRow(icon: "qrcode", title: "Create QR Codes", description: "Generate QR codes for URLs, text, WiFi, and more")
                        FeatureRow(icon: "clock", title: "History", description: "Keep track of all your scanned codes")
                        FeatureRow(icon: "hand.raised.fill", title: "Privacy First", description: "All data stays on your device")
                        FeatureRow(icon: "dollarsign.circle", title: "No Ads", description: "Completely free with optional tips")
                        FeatureRow(icon: "chevron.left.forwardslash.chevron.right", title: "Open Source", description: "Built in the open, for everyone")
                    }
                    .padding(.horizontal)

                    Divider()
                        .padding(.horizontal)

                    VStack(spacing: 12) {
                        Text("Made with ❤️ for the iOS community")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        Text("Licensed under MIT License")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.bottom, 40)
                }
            }
            .navigationTitle("About")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        isPresented = false
                    }
                }
            }
        }
    }
}

struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 30)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .fontWeight(.semibold)
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
    }
}
