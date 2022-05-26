//
//  UIImageExtension.swift
//  VideoDisplay
//
//  Created by đào sơn on 23/05/2022.
//

import Foundation
import AVFoundation
import UIKit
extension UIImage
{
    static func videoPreviewImage(url: URL) -> UIImage? {
        let asset = AVURLAsset(url: url)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        if let cgImage = try? generator.copyCGImage(at: CMTime(seconds: 2, preferredTimescale: 60), actualTime: nil) {
            return UIImage(cgImage: cgImage)
        }
        else {
            return nil
        }
    }
}
