//
//  GroupListViewModel.swift
//  workspace-hub
//
//  Created by František on 19.04.2024.
//

import Foundation
import SwiftUI

final class GroupListViewModel: ViewModelProtocol {
    
    let groupService: GroupServiceProtocol
    
    @Published var state: ViewState = .idle
    
    @Published var name: FieldValue<String> = FieldValue("")
    
    @Published var groups: [Group] = []
    
    @Published var workspaceGroups: [Group] = []
    
    init(groupService: GroupServiceProtocol) {
        self.groupService = groupService
    }
    
    func getGroupsOfCurrentUser() async {
        state = .loading
        do {
            groups = await groupService.getGroupsOfCurrentUser()
            state = .success
        }
    }
    
    func createGroup() async {
        do {
            if let user = AuthService.shared.getCurrentUser()?.uid {
                let newGroup = Group(ownerId: user, name: name.value, members: [], events: [])
                
                if let createdGroup = await groupService.createGroup(group: newGroup) {
                    groups.append(createdGroup)
                }
            } else {
                print("User is not logged in or user ID is not available")
            }
        }
    }
}
