//
//  FruitListView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 15.03.2024.
//

import SwiftUI

struct RootTabView: View {
    
    @EnvironmentObject var mainRouter: MainRouter
        
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.grey700)
        UITabBar.appearance().backgroundColor = .white
    }
    
    var body: some View {
        TabView {
            WorkspaceRootView()
            .tabItem {
                Label("Workspaces", systemImage: "person.2.crop.square.stack")
            }
            
            GroupRootView()
            .tabItem {
                Label("Groups", systemImage: "person.2")
                    .foregroundStyle(.secondary900)
            }
            
            TimelineRootView()
            .tabItem {
                Label("Timeline", systemImage: "calendar.day.timeline.left")
                    .foregroundStyle(.secondary900)
            }
            
            SettingRootView()
            .tabItem {
                Label("Settings", systemImage: "ellipsis")
                    .foregroundStyle(.secondary900)
            }
        }
        .toolbarColorScheme(.light, for: .tabBar)
    }
}
