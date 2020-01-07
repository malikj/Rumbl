//  Rumbl-Assignment
//
//  Created by malikj on 05/01/20.
//  Copyright © 2020 malikj. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

typealias ImageCacheLoaderCompletionHandler = ((UIImage?) -> ())

class ImageLoader {
    
    var cache: NSCache<NSString, UIImage>!
    init() {
        self.cache = NSCache()
    }
    func getThumbnailImageFromVideoUrl(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
        DispatchQueue.global().async {
            let asset = AVAsset(url: url)
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset)
            avAssetImageGenerator.appliesPreferredTrackTransform = true
            let thumnailTime = CMTimeMake(value: 2, timescale: 1)
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil)
                let thumbImage = UIImage(cgImage: cgThumbImage)
                DispatchQueue.main.async {
                    completion(thumbImage)
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }

    func obtainImageWithPath(imagePath: String, completionHandler: @escaping ImageCacheLoaderCompletionHandler) {
        if let image = self.cache.object(forKey: imagePath as NSString) {
            DispatchQueue.main.async {
                completionHandler(image)
            }
        } else {
            let url: URL! = URL(string: imagePath)
            getThumbnailImageFromVideoUrl(url: url) { thumbnailImage in
                if(thumbnailImage != nil) {
                    self.cache.setObject(thumbnailImage!, forKey: imagePath as NSString)
                    DispatchQueue.main.async {
                        completionHandler(thumbnailImage!)
                    }
                }
//                else {
//                    DispatchQueue.main.async {
//                        completionHandler(nil)
//                    }
//                }
            }
        }
    }
}
