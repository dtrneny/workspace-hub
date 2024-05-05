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
                WorkspaceGroupChatView(groupId: groupId, workspaceId: workspaceId)
                    .toolbar(.hidden, for: .tabBar)
                
            case .groupSettingList(let groupId, let workspaceId):
                WorkspaceGroupSettingListView(groupId: groupId, workspaceId: workspaceId)
                    .toolbar(.hidden, for: .tabBar)
                
            case .groupEdit(let groupId, let workspaceId):
                WorkspaceGroupEditView(workspaceId: workspaceId, groupId: groupId)
                    .toolbar(.hidden, for: .tabBar)
                
            case .memberList(let groupId):
                WorkspaceGroupMemberListView(groupId: groupId)
                    .toolbar(.hidden, for: .tabBar)
                
            case .memberInvitation(let groupId):
                WorkspaceGroupInvitationAdditionView(groupId: groupId)
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
                
            case .groupChat(let groupId):
                GroupChatView(groupId: groupId)
                    .toolbar(.hidden, for: .tabBar)
            
            case .groupSettings(let groupId):
                GroupSettingListView(groupId: groupId)
                    .toolbar(.hidden, for: .tabBar)
                
            case .groupGeneral(let groupId):
                GroupGeneralView(groupId: groupId)
                    .toolbar(.hidden, for: .tabBar)
                
            case .groupMembers(let groupId):
                GroupMemberListView(groupId: groupId)
                    .toolbar(.hidden, for: .tabBar)
                
            }
        } else {
            GroupListView()
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
            TimelineView()
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
