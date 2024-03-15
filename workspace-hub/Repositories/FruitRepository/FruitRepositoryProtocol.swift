//
//  FruitProtocol.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 15.03.2024.
//

import Foundation

protocol FruitRepositoryProtocol {
    func addFruit(fruit: Fruit, completion: @escaping (Bool, Error?) -> Void)
    func fetchFruits(completion: @escaping ([Fruit]?, Error?) -> Void)
}
