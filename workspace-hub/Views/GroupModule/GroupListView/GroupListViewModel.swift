//
//  GroupListViewModel.swift
//  workspace-hub
//
//  Created by František on 19.04.2024.
//

import Foundation

final class GroupListViewModel: ViewModelProtocol {
    
    @Published var state: ViewState = .idle
    
    let groupService: GroupServiceProtocol
    
    init(groupService: GroupServiceProtocol) {
        self.groupService = groupService
    }
    
    @Published var groups: [Group] = []
    @Published var workspaceGroups: [Group] = []
    @Published var presentAddition: Bool = false
        
    @Validated(rules: [nonEmptyRule])
    var groupName: String = ""
    @Published var groupNameError: String? = nil
    
    func getGroupsOfCurrentUser() async {
        state = .loading
        do {
            groups = await groupService.getGroupsOfCurrentUser()
            state = .success
        }
    }
}
