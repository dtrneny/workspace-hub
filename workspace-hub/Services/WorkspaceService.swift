//
//  WorkspaceService.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 07.04.2024.
//

import Foundation

protocol WorkspaceServiceProtocol {
    func getWorkspaces() async -> [Workspace]
    func createWorkspace(workspace: Workspace) async -> Workspace?
}

class WorkspaceService: WorkspaceServiceProtocol, ObservableObject {
    
    private var repository = FirestoreRepository<Workspace>(collection: "workspaces")
    
    func getWorkspaces() async -> [Workspace] {
        do {
            let workspaces = try await repository.fetchData().get()
            return workspaces
        }
        catch {
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
}
