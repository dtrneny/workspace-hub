//
//  GroupAdditionViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 21.04.2024.
//

import Foundation

final class GroupAdditionViewModel: ViewModelProtocol {
    
    @Published var state: ViewState = .idle
    
    let groupService: GroupServiceProtocol
    
    init(groupService: GroupServiceProtocol) {
        self.groupService = groupService
    }
    
    @Validated(rules: [nonEmptyRule])
    var groupName: String = ""
    @Published var groupNameError: String? = nil
    
    func createGroup() async -> Bool {
        
        if (!$groupName.isValid()) {
            groupNameError = $groupName.getError()
            return false
        }
        
        guard let userId = AuthService.shared.getCurrentUser()?.uid else {
            return false
        }
        
        let newGroup = Group(ownerId: userId, name: groupName, members: [], events: [])
        
        let _ = await groupService.createGroup(group: newGroup)
        return true
    }
    
}
