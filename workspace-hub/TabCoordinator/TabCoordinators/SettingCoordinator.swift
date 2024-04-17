//
//  SettingCoordinator.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import Foundation

enum SettingTabSections: Hashable {
    case list
}

class SettingCoordinator: BaseTabCoordinator<SettingTabSections> {
    override init() {
        super.init()
        self.changeSection(to: .list)
    }
}
