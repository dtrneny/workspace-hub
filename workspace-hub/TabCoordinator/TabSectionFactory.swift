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
    static func viewForWorkspaceTabSection(history: [WorkspaceTabSections]) -> some View {
        if let currentSection = history.last {
            switch currentSection {
            case .list:
                WorkspaceListView()
            case .detail(let id):
                WorkspaceDetailView(workspaceId: id)
            }
        } else {
            WorkspaceListView()
        }
    }
    
    @ViewBuilder
    static func viewForGroupTabSection(history: [GroupTabSections]) -> some View {
        if let currentSection = history.last {
            switch currentSection {
            case .list:
                GroupListView()
            case .detail:
                Text("Detail")
            }
        } else {
            Text("Default")
        }
    }
    
    @ViewBuilder
    static func viewForTimelineTabSection(history: [TimelineTabSections]) -> some View {
        if let currentSection = history.last {
            switch currentSection {
            case .timeline:
                TimelineView()
            }
        } else {
            Text("Default")
        }
    }
    
    @ViewBuilder
    static func viewForSettingTabSection(history: [SettingTabSections]) -> some View {
        if let currentSection = history.last {
            switch currentSection {
            case .list:
                SettingListView()
            }
        } else {
            Text("Default")
        }
    }
}
