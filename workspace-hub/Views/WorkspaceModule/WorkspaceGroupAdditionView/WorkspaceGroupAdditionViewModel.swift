//
//  GroupAdditionViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 21.04.2024.
//

import Foundation

final class WorkspaceGroupAdditionViewModel: ViewModelProtocol {
    
    @Published var state: ViewState = .idle
    
    let groupService: GroupServiceProtocol
    let workspaceService: WorkspaceServiceProtocol
    
    init(groupService: GroupServiceProtocol, workspaceService: WorkspaceServiceProtocol) {
        self.groupService = groupService
        self.workspaceService = workspaceService
    }
    
    @Published var selectedIcon: String = "person.2.fill"
    @Published var symbolSelectPresented: Bool = false
    @Published var creatingGroup: Bool = false
    @Published var workspace: Workspace? = nil
    
    @Validated(rules: [nonEmptyRule])
    var groupName: String = ""
    @Published var groupNameError: String? = nil
    
    func fetchInitialData(workspaceId: String) async {
        state = .loading
        
        await getWorkspace(workspaceId: workspaceId)
        
        state = .idle
    }
    
    func getWorkspace(workspaceId: String) async {
        do {
            workspace = await workspaceService.getWorkspace(id: workspaceId)
        }
    }
    
    func createGroup(workspaceId: String) async -> Bool {
        if (!$groupName.isValid()) {
            groupNameError = $groupName.getError()
            return false
        }
        
        creatingGroup = true
        guard let userId = AuthService.shared.getCurrentUser()?.uid else {
            creatingGroup = false
            return false
        }
        
        guard var workspace = workspace else {
            creatingGroup = false
            return false
        }
        
        let newGroup = Group(ownerId: userId, name: groupName, icon: selectedIcon, members: [], events: [])
        
        guard let groupId = await groupService.createGroup(group: newGroup)?.id else {
            creatingGroup = false
            return false
        }
        
        workspace.groups += [groupId]
        
        let workspaceUpdate = Workspace(ownerId: workspace.ownerId, name: workspace.name, icon: workspace.icon, hexColor: workspace.hexColor, groups: workspace.groups)
        let _ = await workspaceService.updateWorkspace(id: workspaceId, update: workspaceUpdate)
        
        creatingGroup = false
        return true
    }
    
}
