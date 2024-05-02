//
//  WorkspaceListView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import SwiftUI

struct WorkspaceListView: View {
    
    @EnvironmentObject var coordinator: WorkspaceCoordinator
    
    @StateObject private var viewModel = WorkspaceListViewModel(
        workspaceService: WorkspaceService()
    )
    
    var body: some View {
        BaseLayout {
            switch viewModel.state {
            case .loading:
                LoadingDots(type: .view)
            default:
                VStack(spacing: 38) {
                    newestMessage
                    
                    workspaces
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchInitialData()
            }
        }
    }
}

extension WorkspaceListView {
    
    private var newestMessage: some View {
        VStack(alignment: .leading) {
            ViewTitle(title: "Newest message")
            WorkspaceActivityCard (
                title: "Naomi Foo",
                text: "Hey there! Just wanted to touch base and say thanks for all your hard  work on editing the video. Really appreciate your dedication to making  it...",
                image: "logo"
            ) {
                print("clicked")
            }
        }
    }
    
    private var workspaces: some View {
        VStack(alignment: .leading) {
            
            HStack(alignment: .firstTextBaseline) {
                ViewTitle(title: "Workspaces")
                
                Spacer()
                
                OperationButton(icon: "plus") {
                    coordinator.changeSection(to: .workspaceAddition)
                }
            }
            
            ScrollView {
                if viewModel.workspaces.isEmpty {
                    Text("There are no workspaces...")
                        .font(.inter(14.0))
                        .padding()
                } else {
                    ForEach(viewModel.workspaces) { workspace in
                        WorkspaceListRow(
                            title: workspace.name,
                            symbol: workspace.icon,
                            backgroundHexString: workspace.hexColor,
                            notificationCount: 5
                        ) {
                            if let workspaceId = workspace.id {
                                coordinator.changeSection(to: .detail(id: workspaceId))
                            }
                        }
                    }
                }
            }
        }
    }
    
}

#Preview {
    WorkspaceListView()
}
