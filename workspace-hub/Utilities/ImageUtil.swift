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
    
    static func getUniqueIdentifierForUserImage(userId: String) -> String {
        return "\(userId)_\(UUID().uuidString)"
    }
}
