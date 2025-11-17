//
//  CreateView.swift
//  QRude
//

import SwiftUI

struct CreateView: View {
    @State private var inputText = ""
    @State private var generatedImage: UIImage?
    @State private var showingShareSheet = false
    @State private var selectedType: QRContentType = .text

    enum QRContentType: String, CaseIterable {
        case text = "Text"
        case url = "URL"
        case email = "Email"
        case phone = "Phone"
        case sms = "SMS"
        case wifi = "WiFi"

        var icon: String {
            switch self {
            case .text: return "text.alignleft"
            case .url: return "link"
            case .email: return "envelope"
            case .phone: return "phone"
            case .sms: return "message"
            case .wifi: return "wifi"
            }
        }

        var placeholder: String {
            switch self {
            case .text: return "Enter any text"
            case .url: return "https://example.com"
            case .email: return "example@email.com"
            case .phone: return "+1234567890"
            case .sms: return "+1234567890"
            case .wifi: return "SSID;Password;WPA"
            }
        }
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Type selector
                    VStack(alignment: .leading, spacing: 8) {
                        Text("QR Code Type")
                            .font(.headline)
                            .foregroundColor(.secondary)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(QRContentType.allCases, id: \.self) { type in
                                    Button {
                                        selectedType = type
                                        inputText = ""
                                        generatedImage = nil
                                    } label: {
                                        HStack {
                                            Image(systemName: type.icon)
                                            Text(type.rawValue)
                                        }
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 10)
                                        .background(selectedType == type ? Color.blue : Color.gray.opacity(0.2))
                                        .foregroundColor(selectedType == type ? .white : .primary)
                                        .cornerRadius(20)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top)

                    // Input field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Content")
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)

                        if selectedType == .wifi {
                            VStack(spacing: 12) {
                                TextField("Network Name (SSID)", text: $wifiSSID)
                                    .textFieldStyle(.roundedBorder)

                                SecureField("Password", text: $wifiPassword)
                                    .textFieldStyle(.roundedBorder)

                                Picker("Security", selection: $wifiSecurity) {
                                    Text("WPA/WPA2").tag("WPA")
                                    Text("WEP").tag("WEP")
                                    Text("None").tag("nopass")
                                }
                                .pickerStyle(.segmented)
                            }
                            .padding(.horizontal)
                        } else {
                            TextEditor(text: $inputText)
                                .frame(minHeight: 100)
                                .padding(8)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                )
                                .padding(.horizontal)
                        }

                        if selectedType != .wifi {
                            Text(selectedType.placeholder)
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .padding(.horizontal)
                        }
                    }

                    // Generate button
                    Button {
                        generateQRCode()
                    } label: {
                        Label("Generate QR Code", systemImage: "qrcode")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(canGenerate ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .disabled(!canGenerate)
                    .padding(.horizontal)

                    // Generated QR Code
                    if let image = generatedImage {
                        VStack(spacing: 16) {
                            Image(uiImage: image)
                                .interpolation(.none)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 300, maxHeight: 300)
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(radius: 5)

                            HStack(spacing: 16) {
                                Button {
                                    showingShareSheet = true
                                } label: {
                                    Label("Share", systemImage: "square.and.arrow.up")
                                        .frame(maxWidth: .infinity)
                                }
                                .buttonStyle(.borderedProminent)

                                Button {
                                    saveToPhotos(image)
                                } label: {
                                    Label("Save", systemImage: "square.and.arrow.down")
                                        .frame(maxWidth: .infinity)
                                }
                                .buttonStyle(.bordered)
                            }
                            .padding(.horizontal)
                        }
                        .padding(.vertical)
                    }

                    Spacer()
                }
            }
            .navigationTitle("Create QR Code")
            .sheet(isPresented: $showingShareSheet) {
                if let image = generatedImage {
                    ShareSheet(items: [image])
                }
            }
        }
    }

    // WiFi fields
    @State private var wifiSSID = ""
    @State private var wifiPassword = ""
    @State private var wifiSecurity = "WPA"

    private var canGenerate: Bool {
        if selectedType == .wifi {
            return !wifiSSID.isEmpty
        } else {
            return !inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    }

    private func generateQRCode() {
        let content: String

        switch selectedType {
        case .text:
            content = inputText
        case .url:
            if inputText.lowercased().hasPrefix("http://") || inputText.lowercased().hasPrefix("https://") {
                content = inputText
            } else {
                content = "https://" + inputText
            }
        case .email:
            content = "mailto:\(inputText)"
        case .phone:
            content = "tel:\(inputText)"
        case .sms:
            content = "sms:\(inputText)"
        case .wifi:
            // WIFI:T:WPA;S:mynetwork;P:mypass;;
            content = "WIFI:T:\(wifiSecurity);S:\(wifiSSID);P:\(wifiPassword);;"
        }

        generatedImage = QRGenerator.generate(from: content, size: CGSize(width: 512, height: 512))
    }

    private func saveToPhotos(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
