//
//  WorkspaceDetailViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 26.04.2024.
//

import Foundation

final class WorkspaceDetailViewModel: ViewModelProtocol {
    
    @Published var state: ViewState = .loading
    
    let workspaceService: WorkspaceServiceProtocol
    let groupService: GroupServiceProtocol
    
    init(workspaceService: WorkspaceServiceProtocol, groupService: GroupServiceProtocol) {
        self.workspaceService = workspaceService
        self.groupService = groupService
    }
    
    @Published var workspace: Workspace? = nil
    @Published var workspaceGroups: [Group] = []
    
    func fetchInitialData(workspaceId: String) async {
        state = .loading
        
        await getWorkspace(workspaceId: workspaceId)
        
        if let groupIds = workspace?.groups {
            async let groups = getWorkspaceGroups(ids: groupIds)
            workspaceGroups = await groups
        }
        
        state = .idle
    }
    
    func getWorkspace(workspaceId: String) async {
        do {
            workspace = await workspaceService.getWorkspace(id: workspaceId)
        }
    }
    
    func getWorkspaceGroups(ids: [String]) async -> [Group] {
        var groups: [Group] = []
            
        for id in ids {
            async let group = groupService.getGroup(id: id)
            if let fetchedGroup = await group {
                groups.append(fetchedGroup)
            }
        }
        
        return groups
    }
}
