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
    case addition
    case edit(workspaceId: String)
}

class WorkspaceCoordinator: BaseTabCoordinator<WorkspaceTabSections> {
    override init() {
        super.init()
        self.changeSection(to: .list)
    }
}
