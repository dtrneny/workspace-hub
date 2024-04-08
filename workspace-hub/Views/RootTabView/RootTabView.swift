//
//  FruitListView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 15.03.2024.
//

import SwiftUI

struct RootTabView: View {
    
    @EnvironmentObject var router: Router
    @StateObject private var viewModel = RootTabViewModel()
    
    var body: some View {
        BaseLayout {
            TabView {
                ZStack {
                    Color.white
                        .ignoresSafeArea()
                    
                    VStack {
                        Text("Menu")
                        Button("Sign Out") {
                            if (viewModel.signOut()) {
                                router.navigate(route: .signIn)
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
                
                ZStack {
                    Color.white
                        .ignoresSafeArea()
                    
                    Text("Order")
                        .foregroundStyle(.secondary900)
                }
                .routerBarBackArrowHidden(true)
                .tabItem {
                    Label("Order", systemImage: "square.and.pencil")
                }
            }
            .toolbarColorScheme(.light, for: .tabBar)
        }
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
