//
//  GroupService.swift
//  workspace-hub
//
//  Created by František on 19.04.2024.
//

import Foundation
import FirebaseFirestore

protocol GroupServiceProtocol {
    func getGroups(assembleQuery: @escaping (Query) -> Query) async -> [Group]
    func createGroup(group: Group) async -> Group?
    func getGroup(id: String) async -> Group?
    func updateGroup(id: String, update: Group) async -> Group?
    func deleteGroups(assembleQuery: @escaping (Query) -> Query) async -> Bool
    func deleteGroup(id: String) async -> Bool
}

class GroupService: GroupServiceProtocol, ObservableObject {
    private var repository = FirestoreRepository<Group>(collection: "groups")
            
    func getGroups(assembleQuery: @escaping (Query) -> Query) async -> [Group] {
        do {
            return try await repository.fetchData(assembleQuery: assembleQuery).get()
        } catch {
            return []
        }
    }
    
    func createGroup(group: Group) async -> Group? {
        do {
            let newGroup = try await repository.create(data: group).get()
            return newGroup
        }
        catch {
            return nil
        }
    }
    
    func getGroup(id: String) async -> Group? {
        do {
            let group = try await repository.getById(id: id).get()
            return group
        }
        catch {
            return nil
        }
    }
    
    func updateGroup(id: String, update: Group) async -> Group? {
        do {
            return try await repository.update(id: id, data: update).get()
        }
        catch {
            return nil
        }
    }
    
    func deleteGroups(assembleQuery: @escaping (Query) -> Query) async -> Bool {
        do {
            return try await repository.delete(assembleQuery: assembleQuery).get()
        }
        catch {
            return false
        }
    }
    
    func deleteGroup(id: String) async -> Bool {
        do {
            return try await repository.delete(id: id).get()
        }
        catch {
            return false
        }
    }
}
