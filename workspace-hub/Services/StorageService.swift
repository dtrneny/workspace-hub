//
//  StorageService.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import Foundation
import FirebaseStorage
import SwiftUI

final class StorageService {
    
    static let shared = StorageService()
    private let storage = Storage.storage().reference()
    
    private init() { }
    
    func getData(path: String) async throws -> Data {
        let data = try await storage.child(path).data(maxSize: 1 * 1024 * 1024)
        return data
    }
    
    func getImage(folder: StorageFolder, path: String) async -> Result<UIImage?, Error> {
        do {
            let data = try await getData(path: path)
            
            guard let image = UIImage(data: data) else {
                return .success(nil)
            }
            
            return .success(image)

        } catch {
            return .failure(error)
        }
    }
    
    func getUrlForImage(path: String) async -> Result<URL, Error> {
        do {
            let url = try await Storage.storage().reference(withPath: path).downloadURL()
            return .success(url)
        } catch {
            return .failure(error)
        }
    }

    func saveImage(data: Data, folder: StorageFolder, path: String) async -> Result<(path: String, name: String)?, Error> {
        do {
            let meta = StorageMetadata()
            meta.contentType = "image/jpeg"
            
            let uploadResult = try await storage.child(folder.rawValue).child(path).putDataAsync(data, metadata: meta)
            
            guard let returnedPath = uploadResult.path, let returnedName = uploadResult.name else {
                return .success(nil)
            }
            
            return .success((returnedPath, returnedName))
            
        } catch {
            return .failure(error)
        }
    }
}
