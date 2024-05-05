//
//  ImageCache.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 05.05.2024.
//

import Foundation
import SwiftUI

class ImageCache {
    static let shared = ImageCache()
    
    private var cache = NSCache<NSString, UIImage>()
    
    func getImage(urlString: String) -> UIImage? {
        if let cachedImage = cache.object(forKey: urlString as NSString) {
            return cachedImage
        }
        return nil
    }
    
    func setImage(image: UIImage, urlString: String) {
        cache.setObject(image, forKey: urlString as NSString)
    }
}
