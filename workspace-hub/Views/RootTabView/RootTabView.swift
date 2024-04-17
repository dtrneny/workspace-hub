//
//  FruitListView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 15.03.2024.
//

import SwiftUI

struct RootTabView: View {
    
    @EnvironmentObject var mainRouter: MainRouter
    @StateObject private var viewModel = RootTabViewModel()
    
    var body: some View {
        TabView {
            
            GroupListView()
            .tabItem {
                Label("Menu", systemImage: "list.dash")
                    .foregroundStyle(.secondary900)
            }
            
            WorkspaceRootView()
            .tabItem {
                Label("Order", systemImage: "square.and.pencil")
            }
            
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                VStack {
                    Button("Sign Out") {
                        if (viewModel.signOut()) {
                            mainRouter.replaceAll(with: .signIn)
                        }
                    }
                    .filledButtonStyle()
                }
                    .foregroundStyle(.secondary900)
            }
            .tabItem {
                Label("Menu", systemImage: "list.dash")
                    .foregroundStyle(.secondary900)
            }
        }
        .toolbarColorScheme(.light, for: .tabBar)
    }
}

// MARK: add mock
#Preview {

    struct Preview: View {
        var body: some View {
            RootTabView()
        }
    }
    
    return Preview()
}
