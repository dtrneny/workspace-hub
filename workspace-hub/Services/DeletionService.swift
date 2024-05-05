//
//  DeletionService.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 03.05.2024.
//

import SwiftUI
import FirebaseFirestore

final class DeletionService {

    static let shared = DeletionService()
    
    private let workspaceService: WorkspaceServiceProtocol = WorkspaceService()
    private let groupService: GroupServiceProtocol = GroupService()
    private let messageService: MessageServiceProtocol = MessageService()

    func deleteWorkspace(workspace: Workspace) async -> Bool {
        if let workspaceId = workspace.id {
            let groupsDeleted = await deleteGroups(groupIds: workspace.groups)
            let workspaceDeleted = await workspaceService.deleteWorkspace(id: workspaceId)
            
            return groupsDeleted && workspaceDeleted
        }
        
        return false
    }
    
    func deleteGroups(groupIds: [String]) async -> Bool {
        if (groupIds.isEmpty) {
            return false
        }
        
        let messagesDeleted = await messageService.deleteMessages { query in
            query.whereField("groupId", in: groupIds)
        }
        
        let groupsDeleted = await groupService.deleteGroups { query in
            query.whereField(FieldPath.documentID(), in: groupIds)
        }
        
        return messagesDeleted && groupsDeleted
    }
    
    func deleteGroup(group: Group, workspaceId: String) async -> Bool {
        if let groupId = group.id {
            
            let workspace = await workspaceService.getWorkspace(id: workspaceId)
            
            if var workspace = workspace {
                let newGroups = workspace.groups.filter { $0 != groupId }
                workspace.groups = newGroups
                
                let _ = await workspaceService.updateWorkspace(id: workspaceId, update: workspace)
            }
            
            let messagesDeleted = await messageService.deleteMessages { query in
                query.whereField("groupId", isEqualTo: groupId)
            }
            
            let groupDeleted = await groupService.deleteGroup(id: groupId)

            return groupDeleted && messagesDeleted
        }
        
        return false
    }
}

