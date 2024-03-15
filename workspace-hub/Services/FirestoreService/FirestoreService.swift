//
//  FirestoreService.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 15.03.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirestoreService {
    let firestore = Firestore.firestore()

    func get<T: Codable>(collection: String, completion: @escaping ([T]?, Error?) -> Void) {
        firestore.collection(collection).addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                completion(nil, nil)
                return
            }
            
            let data = documents.compactMap { queryDocumentSnapshot -> T? in
                try? queryDocumentSnapshot.data(as: T.self)
            }
            completion(data, nil)
        }
    }
    
    func post<T: Encodable>(collection: String, item: T, completion: @escaping (Bool, Error?) -> Void) {
        guard (try? firestore.collection(collection).addDocument(from: item)) != nil else {
            completion(false, nil)
            return
        }
    
        completion(true, nil)
    }
}

