//
//  ImageUtil.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 28.04.2024.
//

import Foundation
import SwiftUI

final class ImageUtil {
    
    static func loadImageFromUrl(urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else {
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                if let loadedImage = UIImage(data: data) {
                    completion(loadedImage)
                } else {
                    completion(nil)
                }
            }
        }.resume()
    }
    
    static func loadImageFromUrlAsyncToCache(urlString: String) async {
        if let _ = ImageCache.shared.getImage(urlString: urlString) {
            return
        }
                
        guard let url = URL(string: urlString) else {
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let loadedImage = UIImage(data: data) {
                ImageCache.shared.setImage(image: loadedImage, urlString: urlString)
            }
        } catch {
            return
        }
    }
    
    static func getUniqueIdentifierForUserImage(userId: String) -> String {
        return "\(userId)_\(UUID().uuidString)"
    }
    
    static func loadImagesFromUrlsAsync(imageUrls: [String]) async {        
        await imageUrls.asyncForEach { url in
            await loadImageFromUrlAsyncToCache(urlString: url)
        }
    }

}
