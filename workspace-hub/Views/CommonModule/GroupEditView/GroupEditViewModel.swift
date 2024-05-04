//
//  GroupEditViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 03.05.2024.
//

import Foundation

final class GroupEditViewModel: ViewModelProtocol {
    
    @Published var state: ViewState = .loading
    
    let groupService: GroupServiceProtocol
    
    init(groupService: GroupServiceProtocol) {
        self.groupService = groupService
    }
        
    @Published var selectedIcon: String = "person.3.fill"
    @Published var symbolSelectPresented: Bool = false
    @Published var updatingGroup: Bool = false
    @Published var deletingGroup: Bool = false
    
    var group: Group? = nil

    @Validated(rules: [nonEmptyRule])
    var groupName: String = ""
    @Published var groupNameError: String? = nil
    
    func fetchInitialData(groupId: String) async {
        state = .loading

        await getGroup(groupId: groupId)
        
        state = .idle
    }
    
    func getGroup(groupId: String) async {
        if let result = await groupService.getGroup(id: groupId) {
            group = result
            selectedIcon = result.icon
            groupName = result.name
        }
    }
    
    func deleteGroup(workspaceId: String) async -> Bool {
        if let group = group {
            deletingGroup = true
            return await DeletionService().deleteGroup(group: group, workspaceId: workspaceId)
        }
        
        deletingGroup = false
        return false
    }
    
    func updateGroup() async -> Bool {
        if (!$groupName.isValid()) {
            groupNameError = $groupName.getError()
            
            return false
        }
        
        updatingGroup = true
        
        guard let group = group, let groupId = group.id else {
            updatingGroup = false
            return false
        }
        
        let update = Group(name: groupName, icon: selectedIcon, members: group.members, events: group.events)
                                
        let _ = await groupService.updateGroup(id: groupId, update: update)
        
        updatingGroup = false
        return true
    }
}
