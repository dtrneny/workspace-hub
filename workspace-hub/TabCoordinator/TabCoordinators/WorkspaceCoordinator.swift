//
//  WorkspaceCoordinator.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import Foundation

enum WorkspaceTabSections: Hashable {
    case list
    case detail(id: String)
    case workspaceAddition
    case edit(workspaceId: String)
    case groupAddition(workspaceId: String)
    case groupDetail(groupId: String, workspaceId: String)
    case groupSettingList(groupId: String, workspaceId: String)
    case groupEdit(groupId: String, workspaceId: String)
    case memberList(groupId: String)
    case memberInvitation(groupId: String)
}

class WorkspaceCoordinator: BaseTabCoordinator<WorkspaceTabSections> {
    override init() {
        super.init()
        self.changeSection(to: .list)
    }
}
