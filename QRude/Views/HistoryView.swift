//
//  HistoryView.swift
//  QRude
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var historyManager: HistoryManager
    @State private var searchText = ""
    @State private var showingClearAlert = false

    var filteredItems: [QRCodeItem] {
        if searchText.isEmpty {
            return historyManager.items
        } else {
            return historyManager.items.filter { $0.content.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationView {
            Group {
                if historyManager.items.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "clock.arrow.circlepath")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)

                        Text("No History Yet")
                            .font(.title2)
                            .fontWeight(.semibold)

                        Text("Scanned QR codes will appear here")
                            .foregroundColor(.secondary)
                    }
                } else {
                    List {
                        ForEach(filteredItems) { item in
                            HistoryRowView(item: item)
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        withAnimation {
                                            historyManager.deleteItem(item)
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                                .swipeActions(edge: .leading) {
                                    Button {
                                        historyManager.toggleFavorite(item)
                                    } label: {
                                        Label("Favorite", systemImage: item.isFavorite ? "star.slash" : "star")
                                    }
                                    .tint(.yellow)
                                }
                        }
                    }
                    .searchable(text: $searchText, prompt: "Search history")
                }
            }
            .navigationTitle("History")
            .toolbar {
                if !historyManager.items.isEmpty {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(role: .destructive) {
                            showingClearAlert = true
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                }
            }
            .alert("Clear History", isPresented: $showingClearAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Clear All", role: .destructive) {
                    withAnimation {
                        historyManager.clearHistory()
                    }
                }
            } message: {
                Text("Are you sure you want to clear all history?")
            }
        }
    }
}

struct HistoryRowView: View {
    let item: QRCodeItem
    @State private var showingDetail = false

    var body: some View {
        Button {
            showingDetail = true
        } label: {
            HStack(spacing: 12) {
                Image(systemName: iconForType(item.type))
                    .font(.title2)
                    .foregroundColor(.blue)
                    .frame(width: 30)

                VStack(alignment: .leading, spacing: 4) {
                    Text(item.content)
                        .font(.body)
                        .lineLimit(2)
                        .foregroundColor(.primary)

                    HStack {
                        Text(item.type.rawValue.capitalized)
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("•")
                            .foregroundColor(.secondary)

                        Text(formatDate(item.timestamp))
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }

                Spacer()

                if item.isFavorite {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.caption)
                }

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 4)
        }
        .sheet(isPresented: $showingDetail) {
            HistoryDetailView(item: item, isPresented: $showingDetail)
        }
    }

    private func iconForType(_ type: QRCodeType) -> String {
        switch type {
        case .url: return "link.circle.fill"
        case .email: return "envelope.circle.fill"
        case .phone: return "phone.circle.fill"
        case .sms: return "message.circle.fill"
        case .wifi: return "wifi.circle.fill"
        case .contact: return "person.crop.circle.fill"
        case .text: return "text.alignleft"
        case .unknown: return "qrcode"
        }
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}

struct HistoryDetailView: View {
    let item: QRCodeItem
    @Binding var isPresented: Bool
    @State private var showingCopiedAlert = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: iconForType(item.type))
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                    .padding(.top, 30)

                Text(item.type.rawValue.capitalized)
                    .font(.title2)
                    .fontWeight(.semibold)

                ScrollView {
                    Text(item.content)
                        .font(.body)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                VStack(spacing: 12) {
                    if item.type == .url, let url = URL(string: item.content) {
                        Button(action: {
                            UIApplication.shared.open(url)
                        }) {
                            Label("Open Link", systemImage: "safari")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                    }

                    Button(action: {
                        UIPasteboard.general.string = item.content
                        showingCopiedAlert = true
                    }) {
                        Label("Copy", systemImage: "doc.on.doc")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)

                if showingCopiedAlert {
                    Text("✓ Copied!")
                        .font(.headline)
                        .foregroundColor(.green)
                        .transition(.scale)
                }

                Spacer()
            }
            .navigationTitle("Details")
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

    private func iconForType(_ type: QRCodeType) -> String {
        switch type {
        case .url: return "link.circle.fill"
        case .email: return "envelope.circle.fill"
        case .phone: return "phone.circle.fill"
        case .sms: return "message.circle.fill"
        case .wifi: return "wifi.circle.fill"
        case .contact: return "person.crop.circle.fill"
        case .text: return "text.alignleft"
        case .unknown: return "qrcode"
        }
    }
}
