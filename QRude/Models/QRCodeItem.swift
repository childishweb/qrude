//
//  QRCodeItem.swift
//  QRude
//

import Foundation

enum QRCodeType: String, Codable {
    case url
    case text
    case email
    case phone
    case sms
    case wifi
    case contact
    case unknown

    static func detect(from content: String) -> QRCodeType {
        let lowercased = content.lowercased()

        if lowercased.hasPrefix("http://") || lowercased.hasPrefix("https://") {
            return .url
        } else if lowercased.hasPrefix("mailto:") {
            return .email
        } else if lowercased.hasPrefix("tel:") {
            return .phone
        } else if lowercased.hasPrefix("smsto:") || lowercased.hasPrefix("sms:") {
            return .sms
        } else if lowercased.hasPrefix("wifi:") {
            return .wifi
        } else if lowercased.hasPrefix("begin:vcard") || lowercased.hasPrefix("mecard:") {
            return .contact
        } else {
            return .text
        }
    }
}

struct QRCodeItem: Identifiable, Codable {
    let id: UUID
    let content: String
    let type: QRCodeType
    let timestamp: Date
    var isFavorite: Bool

    init(content: String, isFavorite: Bool = false) {
        self.id = UUID()
        self.content = content
        self.type = QRCodeType.detect(from: content)
        self.timestamp = Date()
        self.isFavorite = isFavorite
    }
}
