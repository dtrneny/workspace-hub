//
//  GroupService.swift
//  workspace-hub
//
//  Created by František on 19.04.2024.
//

import Foundation
import FirebaseAuth

protocol GroupServiceProtocol {
    func getGroupsOfCurrentUser() async -> [Group]
    func createGroup(group: Group) async -> Group?
    func getGroup(id: String) async -> Group?
}

class GroupService: GroupServiceProtocol, ObservableObject {
    private var repository = FirestoreRepository<Group>(collection: "groups")
    
    private var workspaceRepository = FirestoreRepository<Workspace>(collection: "workspaces")
    
    private let firebaseAuth = Auth.auth()
    
    func getGroupsOfCurrentUser() async -> [Group] {
        do {
            guard let user = firebaseAuth.currentUser else {
                return []
            }
            
            let groups = try await repository.fetchData().get()
            let groupsOfCurrentUser = groups.filter {
                $0.members.contains(user.uid)
            }
            return groupsOfCurrentUser
        }
        catch {
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
}
