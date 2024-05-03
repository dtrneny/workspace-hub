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
}
