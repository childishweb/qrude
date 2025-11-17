//
//  ScanView.swift
//  QRude
//

import SwiftUI
import AVFoundation

struct ScanView: View {
    @EnvironmentObject var historyManager: HistoryManager
    @AppStorage("autoOpenLinks") private var autoOpenLinks = false
    @State private var scannedCode: String?
    @State private var showingScannedSheet = false
    @State private var cameraPermission: AVAuthorizationStatus = .notDetermined
    @Binding var selectedTab: Int

    var body: some View {
        NavigationView {
            ZStack {
                if cameraPermission == .authorized {
                    QRScannerView(scannedCode: $scannedCode) { code in
                        handleScannedCode(code)
                    }
                    .edgesIgnoringSafeArea(.all)

                    // Scanning frame overlay
                    VStack {
                        Spacer()

                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white, lineWidth: 3)
                            .frame(width: 280, height: 280)
                            .overlay(
                                VStack(spacing: 20) {
                                    Image(systemName: "viewfinder")
                                        .font(.system(size: 80))
                                        .foregroundColor(.white.opacity(0.8))

                                    Text("Point camera at QR code")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                        .padding(.vertical, 8)
                                        .background(Color.black.opacity(0.6))
                                        .cornerRadius(10)
                                }
                            )

                        Spacer()
                    }
                } else if cameraPermission == .denied {
                    VStack(spacing: 20) {
                        Image(systemName: "camera.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)

                        Text("Camera Access Needed")
                            .font(.title2)
                            .fontWeight(.bold)

                        Text("Please enable camera access in Settings to scan QR codes")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)

                        Button("Open Settings") {
                            if let url = URL(string: UIApplication.openSettingsURLString) {
                                UIApplication.shared.open(url)
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                } else {
                    VStack(spacing: 20) {
                        ProgressView()
                            .scaleEffect(1.5)
                        Text("Requesting camera access...")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Scan QR Code")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingScannedSheet) {
                if let code = scannedCode {
                    ScannedCodeDetailView(
                        code: code,
                        isPresented: $showingScannedSheet,
                        onDismiss: {
                            resetScanner()
                        }
                    )
                }
            }
            .onAppear {
                checkCameraPermission()
            }
        }
    }

    private func checkCameraPermission() {
        cameraPermission = AVCaptureDevice.authorizationStatus(for: .video)

        if cameraPermission == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    cameraPermission = granted ? .authorized : .denied
                }
            }
        }
    }

    private func handleScannedCode(_ code: String) {
        scannedCode = code
        historyManager.addItem(code)

        // Auto-open URLs if setting is enabled
        if autoOpenLinks {
            let qrType = QRCodeType.detect(from: code)
            if qrType == .url, let url = URL(string: code) {
                UIApplication.shared.open(url)
                // Auto-reset scanner after opening
                resetScanner()
                return
            }
        }

        showingScannedSheet = true
    }

    private func resetScanner() {
        // Reset scanner state to allow new scans
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            scannedCode = nil
        }
    }
}

struct ScannedCodeDetailView: View {
    let code: String
    @Binding var isPresented: Bool
    var onDismiss: () -> Void

    @State private var showingCopiedAlert = false

    private var qrType: QRCodeType {
        QRCodeType.detect(from: code)
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // QR Type Icon
                Image(systemName: iconForType(qrType))
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                    .padding(.top, 30)

                Text(typeTitle(qrType))
                    .font(.title2)
                    .fontWeight(.semibold)

                // Code content
                ScrollView {
                    Text(code)
                        .font(.body)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                // Action buttons
                VStack(spacing: 12) {
                    if qrType == .url, let url = URL(string: code) {
                        Button(action: {
                            UIApplication.shared.open(url)
                            dismissAndReset()
                        }) {
                            Label("Open Link", systemImage: "safari")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                    }

                    Button(action: {
                        UIPasteboard.general.string = code
                        showingCopiedAlert = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            dismissAndReset()
                        }
                    }) {
                        Label("Copy to Clipboard", systemImage: "doc.on.doc")
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
            .navigationTitle("Scanned Code")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismissAndReset()
                    }
                }
            }
        }
    }

    private func dismissAndReset() {
        isPresented = false
        onDismiss()
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

    private func typeTitle(_ type: QRCodeType) -> String {
        switch type {
        case .url: return "Website Link"
        case .email: return "Email Address"
        case .phone: return "Phone Number"
        case .sms: return "SMS Message"
        case .wifi: return "WiFi Network"
        case .contact: return "Contact"
        case .text: return "Text"
        case .unknown: return "QR Code"
        }
    }
}
