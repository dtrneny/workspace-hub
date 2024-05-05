//
//  GroupSettingListView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 05.05.2024.
//

import SwiftUI

struct GroupSettingListView: View {
    
    let groupId: String
    
    @EnvironmentObject var coordinator: GroupCoordinator

    var body: some View {
        BaseLayout {
            VStack(spacing: 38) {
                settings
            }
        }
    }
}

extension GroupSettingListView {
    
    private var settings: some View {
        VStack(alignment: .leading) {
            ViewTitle(title: "Group settings")

            SettingListRow(label: "General") {
                coordinator.changeSection(to: .groupGeneral(groupId: groupId))
            }
            SettingListRow(label: "Members") {
                coordinator.changeSection(to: .groupMembers(groupId: groupId))
            }
        }
    }
}
