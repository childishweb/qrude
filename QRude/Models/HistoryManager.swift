//
//  HistoryManager.swift
//  QRude
//

import Foundation

class HistoryManager: ObservableObject {
    @Published var items: [QRCodeItem] = []

    private let userDefaultsKey = "qrude_history"
    private let maxHistoryItems = 100

    init() {
        loadHistory()
    }

    func addItem(_ content: String) {
        // Don't add duplicates at the top
        if let existingIndex = items.firstIndex(where: { $0.content == content }) {
            // Move to top
            let item = items.remove(at: existingIndex)
            items.insert(item, at: 0)
        } else {
            let newItem = QRCodeItem(content: content)
            items.insert(newItem, at: 0)
        }

        // Limit history size
        if items.count > maxHistoryItems {
            items = Array(items.prefix(maxHistoryItems))
        }

        saveHistory()
    }

    func deleteItem(_ item: QRCodeItem) {
        items.removeAll { $0.id == item.id }
        saveHistory()
    }

    func toggleFavorite(_ item: QRCodeItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isFavorite.toggle()
            saveHistory()
        }
    }

    func clearHistory() {
        items.removeAll()
        saveHistory()
    }

    private func saveHistory() {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }

    private func loadHistory() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decoded = try? JSONDecoder().decode([QRCodeItem].self, from: data) {
            items = decoded
        }
    }
}
