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
    
    @Validated(rules: [nonEmptyRule])
    var groupName: String = ""
    @Published var groupNameError: String? = nil
    
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
        
        if (!$groupName.isValid()) {
            groupNameError = $groupName.getError()
            return
        }
        
        do {
            if let user = AuthService.shared.getCurrentUser()?.uid {
                let newGroup = Group(ownerId: user, name: groupName, members: [], events: [])
                
                if let createdGroup = await groupService.createGroup(group: newGroup) {
                    groups.append(createdGroup)
                }
            } else {
                print("User is not logged in or user ID is not available")
            }
        }
    }
}
