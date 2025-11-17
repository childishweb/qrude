//
//  QRGenerator.swift
//  QRude
//

import CoreImage.CIFilterBuiltins
import UIKit

class QRGenerator {
    static func generate(from string: String, size: CGSize = CGSize(width: 512, height: 512)) -> UIImage? {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()

        filter.message = Data(string.utf8)
        filter.correctionLevel = "M" // Medium error correction

        guard let outputImage = filter.outputImage else { return nil }

        // Scale the QR code to desired size
        let scaleX = size.width / outputImage.extent.width
        let scaleY = size.height / outputImage.extent.height
        let transformedImage = outputImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))

        guard let cgImage = context.createCGImage(transformedImage, from: transformedImage.extent) else { return nil }

        return UIImage(cgImage: cgImage)
    }
}
