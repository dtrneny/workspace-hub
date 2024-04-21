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
    @Published var presentAddition: Bool = false

    
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
}
