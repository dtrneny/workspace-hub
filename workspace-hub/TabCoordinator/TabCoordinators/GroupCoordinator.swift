//
//  GroupCoordinator.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import Foundation

enum GroupTabSections: Hashable {
    case list
    case invitations
}

class GroupCoordinator: BaseTabCoordinator<GroupTabSections> {
    override init() {
        super.init()
        self.changeSection(to: .list)
    }
}
