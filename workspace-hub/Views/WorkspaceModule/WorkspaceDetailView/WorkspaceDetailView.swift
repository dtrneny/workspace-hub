//
//  WorkspaceDetailView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 26.04.2024.
//

import SwiftUI

struct WorkspaceDetailView: View {
    
    var workspaceId: String
    @StateObject private var viewModel = WorkspaceDetailViewModel(workspaceService: WorkspaceService())
    @EnvironmentObject var mainRouter: MainRouter
    
    var body: some View {
        BaseLayout {
            if let workspace = viewModel.workspace {
                VStack(spacing: 38) {
                    VStack(alignment: .leading) {
                        HStack(alignment: .firstTextBaseline) {
                            ViewTitle(title: "Detail")
                            
                            Spacer()
                            
                            OperationButton(icon: "pencil") {
                                mainRouter.navigate(to: .workspaceEdit(workspaceId: workspaceId))
                            }
                        }
                        
                        WorkspaceDetailCard(name: workspace.name, icon: workspace.icon, hexColor: workspace.hexColor)
                    }
                    
                    VStack(alignment: .leading) {
                        HStack(alignment: .firstTextBaseline) {
                            ViewTitle(title: "Groups")
                            
                            Spacer()
                            
                            OperationButton(icon: "plus") {
                                print("Add group")
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.getWorkspace(workspaceId: workspaceId)
            }
        }
    }
}
