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
    func getWorkspace(id: String) async -> Workspace?
    func updateWorkspace(id: String, update: Workspace) async -> Workspace?
}

class WorkspaceService: WorkspaceServiceProtocol, ObservableObject {
    
    private var repository = FirestoreRepository<Workspace>(collection: "workspaces")
    
    private var groupRepository = FirestoreRepository<Group>(collection: "groups")
    
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
    
    func updateWorkspace(id: String, update: Workspace) async -> Workspace? {
        do {
            let workspace = try await repository.update(id: id, data: update).get()
            return workspace
        }
        catch {
            return nil
        }
    }
    
    func getGroupsByWorkspaceId(id: String) async -> [Group]? {
        do {
            guard let workspace = try await repository.getById(id: id).get()
            else {
                return []
            }

            let groups = try await groupRepository.fetchData().get()
            let groupsInWorkspace = groups.filter { group in
                workspace.groups.contains { groupId in
                    groupId == group.id
                }
            }
            
            return groupsInWorkspace
        }
        catch {
            return nil
        }
    }
}
