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
            WorkspaceActivityCard (
                title: "Workspace Hub",
                text: "Hey there! We are happy to welcome you to our app.",
                image: "logo"
            ) {}
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
                    EmptyListMessage(message: "There are no workspaces...")
                } else {
                    ForEach(viewModel.workspaces) { workspace in
                        WorkspaceListRow(
                            title: workspace.name,
                            symbol: workspace.icon,
                            backgroundHexString: workspace.hexColor
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
