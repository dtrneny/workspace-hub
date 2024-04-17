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
            case .detail:
                Text("Detail")
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
                Text("List")
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
                Text("List")
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
