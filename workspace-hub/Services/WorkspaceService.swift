//
//  WorkspaceService.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 07.04.2024.
//

import Foundation
import FirebaseFirestore

protocol WorkspaceServiceProtocol {
    func getWorkspaces(assembleQuery: @escaping (Query) -> Query) async -> [Workspace]
    func createWorkspace(workspace: Workspace) async -> Workspace?
    func getWorkspace(id: String) async -> Workspace?
    func updateWorkspace(id: String, update: Workspace) async -> Workspace?
}

class WorkspaceService: WorkspaceServiceProtocol, ObservableObject {
    
    private var repository = FirestoreRepository<Workspace>(collection: "workspaces")
    
    private var groupRepository = FirestoreRepository<Group>(collection: "groups")
    
    func getWorkspaces(assembleQuery: @escaping (Query) -> Query) async -> [Workspace] {
        do {
            return try await repository.fetchData(assembleQuery: assembleQuery).get()

        } catch {
            return []
        }
    }
    
    func createWorkspace(workspace: Workspace) async -> Workspace? {
        do {
            let workspace = try await repository.create(data: workspace).get()
            return workspace
        }
        catch {
            return nil
        }
    }
    
    func getWorkspace(id: String) async -> Workspace? {
        do {
            let workspace = try await repository.getById(id: id).get()
            return workspace
        }
        catch {
            return nil
        }
    }
    
    func updateWorkspace(id: String, update: Workspace) async -> Workspace? {
        do {
            let workspace = try await repository.update(id: id, data: update).get()
            return workspace
        }
        catch {
            return nil
        }
    }
}
