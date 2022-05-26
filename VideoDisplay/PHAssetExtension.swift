//
//  PHAssetExtension.swift
//  VideoDisplay
//
//  Created by đào sơn on 25/05/2022.
//

import Foundation
import Photos
import UIKit
import AVKit
// MARK: - extends PHAsset
extension PHAsset
{
    static func loadRandomPHAssetVideosFromGallery() ->PHAsset?
    {
        var assetImages: [PHAsset] = []
        let assets = PHAsset.fetchAssets(with: PHAssetMediaType.video, options: nil)
        assets.enumerateObjects{
        (object,_,_) in
            assetImages.append(object)
        }
        assetImages.reverse()
        return assetImages.randomElement()
    }
    
    func getAVAsset(completionHandler : @escaping ((_ asset : AVAsset?) -> Void)){
        if self.mediaType == .video {
            let options: PHVideoRequestOptions = PHVideoRequestOptions()
            options.version = .original
            PHImageManager.default().requestAVAsset(forVideo: self, options: options, resultHandler: {(asset: AVAsset?, audioMix: AVAudioMix?, info: [AnyHashable : Any]?) -> Void in
                if let aVAsset = asset {
                    completionHandler(aVAsset)
                } else {
                    completionHandler(nil)
                }
            })
        }
      }
}
