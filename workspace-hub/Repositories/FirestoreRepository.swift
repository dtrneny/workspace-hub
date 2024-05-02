//
//  FirestoreRepository.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 05.04.2024.
//

import Foundation
import FirebaseFirestore

struct QueryOptions {
    var filters: [Filter]?
}

struct Filter {
    var field: String
    var value: Any
}

class FirestoreRepository<T: Codable>: Repository {
    private let collection: String
    private let firestore = Firestore.firestore()
    
    init(collection: String) {
        self.collection = collection
    }
    
    func fetchData(with options: QueryOptions? = nil) async -> Result<[T], Error> {
        var query: Query = firestore.collection(collection)
            
        if let options = options {
            query = applyQueryOptions(query, options: options)
        }
    
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
    
    func update(id: String, update: [String: Any]) async throws -> Result<Bool, Error> {
        do {
            try await firestore
                .collection(collection)
                .document(id)
                .updateData(update)
            
            return .success(true)
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
    
    private func applyQueryOptions(_ query: Query, options: QueryOptions) -> Query {
        var modifiedQuery = query
        
        if let filters = options.filters {
            for filter in filters {
                modifiedQuery = modifiedQuery.whereField(filter.field, isEqualTo: filter.value)
            }
        }
        
        return modifiedQuery
    }
}
