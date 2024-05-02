//
//  WorkspaceDetailView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 26.04.2024.
//

import SwiftUI

struct WorkspaceDetailView: View {
    
    var workspaceId: String
    
    @EnvironmentObject var coordinator: WorkspaceCoordinator
        
    @StateObject private var viewModel = WorkspaceDetailViewModel(
        workspaceService: WorkspaceService(),
        groupService: GroupService()
    )
    
    var body: some View {
        BaseLayout {
            switch viewModel.state {
            case .loading:
                LoadingDots(type: .view)
            default:
                if let workspace = viewModel.workspace {
                    VStack(spacing: 38) {
                        VStack(alignment: .leading) {
                            workspaceCardOperations
                            
                            WorkspaceDetailCard(name: workspace.name, icon: workspace.icon, hexColor: workspace.hexColor)
                        }
                        
                        workspaceGroups
                    }
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchInitialData(workspaceId: workspaceId)
            }
        }
    }
}

extension WorkspaceDetailView {
    
    private var workspaceCardOperations: some View {
        HStack(alignment: .firstTextBaseline) {
            ViewTitle(title: "Detail")
            
            Spacer()
            
            OperationButton(icon: "pencil") {
                coordinator.changeSection(to: .edit(workspaceId: workspaceId))
            }
        }
    }
    
    private var workspaceGroups: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .firstTextBaseline) {
                ViewTitle(title: "Groups")
                
                Spacer()
                
                OperationButton(icon: "plus") {
                    coordinator.changeSection(to: .groupAddition(workspaceId: workspaceId))
                }
            }
            
            ScrollView {
                if viewModel.workspaceGroups.isEmpty {
                    EmptyListMessage(message: "There are no groups...")
                } else {
                    ForEach(viewModel.workspaceGroups) { group in
                        WorkspaceGroupListRow(title: group.name, symbol: group.icon) {
                            if let groupId = group.id {
                                coordinator.changeSection(to: .groupDetail(groupId: groupId))
                            }
                        }
                    }
                }
            }
        }
    }
    
}
