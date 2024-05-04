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
                
            case .groupDetail(let groupId, let workspaceId):
                GroupDetailView(workspaceId: workspaceId, groupId: groupId) {
                    coordinator.changeSection(to: .groupSettingList(groupId: groupId, workspaceId: workspaceId))
                }
                .toolbar(.hidden, for: .tabBar)
                
            case .groupSettingList(let groupId, let workspaceId):
                GroupSettingListView(groupId: groupId, workspaceId: workspaceId) { groupId, workspaceId in
                    coordinator.changeSection(to: .groupEdit(groupId: groupId, workspaceId: workspaceId))
                } navigateToMembers: { groupId in
                    coordinator.changeSection(to: .memberList(groupId: groupId))
                }
                .toolbar(.hidden, for: .tabBar)
                
            case .groupEdit(let groupId, let workspaceId):
                GroupEditView(workspaceId: workspaceId, groupId: groupId) {
                    coordinator.replaceAll(with: [.list, .detail(id: workspaceId)])
                } navigateBack: {
                    coordinator.pop()
                }
                .toolbar(.hidden, for: .tabBar)
                
            case .memberList(let groupId):
                MemberListView(groupId: groupId) { groupId in
                    coordinator.changeSection(to: .memberInvitation(groupId: groupId))
                }
                .toolbar(.hidden, for: .tabBar)
                
            case .memberInvitation(let groupId):
                InvitationAdditionView(groupId: groupId) {
                    coordinator.pop()
                }
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
                GroupListView()
            case .invitations:
                GroupInvitationListView()
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
