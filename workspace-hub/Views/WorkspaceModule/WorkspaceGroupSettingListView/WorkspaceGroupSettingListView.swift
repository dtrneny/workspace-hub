//
//  WorkspaceGroupSettingListView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 05.05.2024.
//

import SwiftUI

struct WorkspaceGroupSettingListView: View {
    
    let groupId: String
    let workspaceId: String
    
    @EnvironmentObject var coordinator: WorkspaceCoordinator

    var body: some View {
        BaseLayout {
            VStack(spacing: 38) {
                settings
            }
        }
    }
}

extension WorkspaceGroupSettingListView {
    
    private var settings: some View {
        VStack(alignment: .leading) {
            ViewTitle(title: "Group settings")

            SettingListRow(label: "General") {
                coordinator.changeSection(to: .groupEdit(groupId: groupId, workspaceId: workspaceId))
            }
            SettingListRow(label: "Members") {
                coordinator.changeSection(to: .memberList(groupId: groupId))
            }
        }
    }
}
