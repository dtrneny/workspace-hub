//
//  FruitRepository.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 15.03.2024.
//

import Foundation
import Combine

class FruitRepository: FruitRepositoryProtocol, ObservableObject {
    private let firestoreService = FirestoreService()
    private let collectionName = "fruits"

    func fetchFruits(completion: @escaping ([Fruit]?, Error?) -> Void) {
        firestoreService.get(collection: collectionName, completion: completion)
    }
    
    func addFruit(fruit: Fruit, completion: @escaping (Bool, (any Error)?) -> Void) {
        firestoreService.post(collection: collectionName, item: fruit, completion: completion)
    }
}
