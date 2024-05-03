//
//  RepositoryProtocol.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 05.04.2024.
//

import Foundation
import FirebaseFirestore

protocol Repository {
    associatedtype Model: Codable
    
    func fetchData() async throws -> Result<[Model], Error>
    func fetchData(assembleQuery: @escaping (Query) -> Query) async throws -> Result<[Model], Error>
    func create(data: Model) async throws -> Result<Model, Error>
    func create(data: Model, id: String) async throws -> Result<Model, Error>
    func getById(id: String) async throws -> Result<Model?, Error>
    func update(id: String, data: Model) async throws -> Result<Model, Error>
    func delete(id: String) async throws -> Result<Bool, Error>
    func listenToCollection(assembleQuery: @escaping (Query) -> Query, completion: @escaping ([Model], Error?) -> Void)
}
