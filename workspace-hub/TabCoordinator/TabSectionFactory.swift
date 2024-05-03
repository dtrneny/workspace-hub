//
//  TabSectionFactory.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import Foundation
import SwiftUI

enum TabSectionFactory {
    @ViewBuilder
    static func viewForWorkspaceTabSection(coordinator: WorkspaceCoordinator) -> some View {
        if let currentSection = coordinator.history.last {
            switch currentSection {
            case .list:
                WorkspaceListView()
            case .detail(let id):
                WorkspaceDetailView(workspaceId: id)
            case .workspaceAddition:
                WorkspaceAdditionView()
                    .toolbar(.hidden, for: .tabBar)
            case .edit(let id):
                WorkspaceEditView(workspaceId: id)
                    .toolbar(.hidden, for: .tabBar)
            case .groupAddition(let id):
                WorkspaceGroupAdditionView(workspaceId: id)
                    .toolbar(.hidden, for: .tabBar)
            case .groupDetail(let id):
                GroupDetailView(groupId: id) {
                    coordinator.changeSection(to: .groupSettingList(groupId: id))
                }
                .toolbar(.hidden, for: .tabBar)
            case .groupSettingList(let id):
                GroupSettingListView(groupId: id)
                    .toolbar(.hidden, for: .tabBar)
            }
        } else {
            WorkspaceListView()
        }
    }
    
    @ViewBuilder
    static func viewForGroupTabSection(coordinator: GroupCoordinator) -> some View {
        if let currentSection = coordinator.history.last {
            switch currentSection {
            case .list:
                Text("List")
            }
        } else {
            Text("Default")
        }
    }
    
    @ViewBuilder
    static func viewForTimelineTabSection(coordinator: TimelineCoordinator) -> some View {
        if let currentSection = coordinator.history.last {
            switch currentSection {
            case .timeline:
                TimelineView()
            }
        } else {
            Text("Default")
        }
    }
    
    @ViewBuilder
    static func viewForSettingTabSection(coordinator: SettingCoordinator) -> some View {
        if let currentSection = coordinator.history.last {
            switch currentSection {
            case .list:
                SettingListView()
            case .accountEdit:
                SettingAccountEditView()
                    .toolbar(.hidden, for: .tabBar)
            }
        } else {
            SettingListView()
        }
    }
}
