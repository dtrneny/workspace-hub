//
//  FirestoreRepository.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 05.04.2024.
//

import Foundation
import FirebaseFirestore

class FirestoreRepository<T: Codable>: Repository {
    private let collection: String
    private let firestore = Firestore.firestore()
    
    init(collection: String) {
        self.collection = collection
    }
    
    func fetchData() async -> Result<[T], Error> {
        do {
            let snapshot = try await firestore.collection(collection).getDocuments()
            let models = snapshot.documents.compactMap { document -> T? in
                do {
                    let model = try document.data(as: T.self)
                    return model
                } catch {
                    return nil
                }
            }
            return .success(models)
        } catch {
            return .failure(error)
        }
    }
    
    func fetchData(assembleQuery: @escaping (Query) -> Query) async -> Result<[T], Error> {
        let query = assembleQuery(firestore.collection(collection))
        
        do {
            let snapshot = try await query.getDocuments()
            let models = snapshot.documents.compactMap { document -> T? in
                do {
                    let model = try document.data(as: T.self)
                    return model
                } catch {
                    return nil
                }
            }
            return .success(models)
        } catch {
            return .failure(error)
        }
    }
    
    func create(data: T) async throws -> Result<T, Error> {
        do {
            let result = try await firestore
                .collection(collection)
                .addDocument(from: data)
                .getDocument(as: T.self)
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
    
    func create(data: T, id: String) async throws -> Result<T, Error> {
        do {
            let docRef = firestore.collection(collection).document(id)
            
            try docRef.setData(from: data)
            
            let result = try await docRef.getDocument(as: T.self)
        
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
    
    func getById(id: String) async throws -> Result<T?, Error> {
        do {
            let result = try await firestore
                .collection(collection)
                .document(id)
                .getDocument(as: T.self)
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
    
    func update(id: String, data: T) async throws -> Result<T, Error> {
        do {
            try firestore
                .collection(collection)
                .document(id)
                .setData(from: data)
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
    
    func delete(id: String) async throws -> Result<Bool, Error> {
        do {
            try await firestore.collection(collection).document(id).delete()
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
    
    func listenToCollection(assembleQuery: @escaping (Query) -> Query, completion: @escaping ([T], Error?) -> Void) {
        let query = assembleQuery(firestore.collection(collection))
        
        query.addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                completion([], error)
                return
            }

            guard let documents = querySnapshot?.documents else {
                completion([], nil)
                return
            }
            

            let data = documents.compactMap { queryDocumentSnapshot -> T? in
                try? queryDocumentSnapshot.data(as: T.self)
            }
            
            completion(data, nil)
        }
    }
}
