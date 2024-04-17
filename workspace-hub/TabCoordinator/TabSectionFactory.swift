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
}
