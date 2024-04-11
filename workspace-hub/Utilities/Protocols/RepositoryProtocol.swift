//
//  RepositoryProtocol.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 05.04.2024.
//

import Foundation

protocol Repository {
    associatedtype Model: Codable
    
    func fetchData() async throws -> Result<[Model], Error>
}