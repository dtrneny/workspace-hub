//
//  FruitListViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 15.03.2024.
//

import Foundation
import SwiftUI

class FruitListViewModel: ViewModelProtocol {
    
    let fruitRepository: FruitRepositoryProtocol

    @Published var fruits: [Fruit] = []
    @Published var state: ViewState = .idle
    @Published var fruitName: String = ""
    @Published var name: String = ""
    
    init(fruitRepository: FruitRepositoryProtocol) {
        self.fruitRepository = fruitRepository
    }
    
    func addFruit(fruit: Fruit) {
        fruitRepository.addFruit(fruit: fruit, completion: { success, error in
            if let error = error {
                print("Error posting fruits: \(error.localizedDescription)")
            } else {
                print("Added \(fruit.name)")
            }
        })
    }
    
    
    func fetchFruits() {
        fruitRepository.fetchFruits { [weak self] fruits, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching fruits: \(error.localizedDescription)")
            } else {
                self.fruits = fruits ?? []
            }
        }
    }
}
