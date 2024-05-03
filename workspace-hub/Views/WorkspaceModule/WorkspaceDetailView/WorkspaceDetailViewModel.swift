//
//  WorkspaceDetailViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 26.04.2024.
//

import Foundation
import FirebaseFirestore

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
            async let groups = getWorkspaceGroups(groupIds: groupIds)
            workspaceGroups = await groups
        }
        
        state = .idle
    }
    
    func getWorkspace(workspaceId: String) async {
        workspace = await workspaceService.getWorkspace(id: workspaceId)
    }
    
    func getWorkspaceGroups(groupIds: [String]) async -> [Group] {
        guard !groupIds.isEmpty else {
            return []
        }
                        
        return await groupService.getGroups { query in
            query.whereField(FieldPath.documentID(), in: groupIds)
        }
    }
}
