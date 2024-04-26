//
//  WorkspaceAdditionView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 20.04.2024.
//

import SwiftUI

struct WorkspaceAdditionView: View {
    
    @Binding var isPresented: Bool
    @EnvironmentObject var coordinator: WorkspaceCoordinator
    @StateObject private var viewModel = WorkspaceAdditionViewModel(workspaceService: WorkspaceService())
    
    var body: some View {
        SheetLayout {
            ViewTitle(title: "Add workspace")
            
            formView
            
            Image(systemName: viewModel.selectedIcon)
                        
            BaseButton {
                Task {
                    if(await viewModel.createWorkspace()) {
                        isPresented = false
                    }
                }
            } content: {
                Text("Create workspace")
            }
        }
    }
}

extension WorkspaceAdditionView {
    
    private var formView: some View {
        VStack(spacing: 19) {
            FormField {
                TextInput(
                    value: $viewModel.workspaceName,
                    placeholder: "Your workspace",
                    label: "Name"
                )
                if let error = viewModel.workspaceNameError {
                    ErrorMessage(error: error)
                }
            }
            FormField {
                TextInput(
                    value: $viewModel.workspaceIcon,
                    placeholder: "heart",
                    label: "Icon"
                )
                if let error = viewModel.workspaceIconError {
                    ErrorMessage(error: error)
                }
            }
        }
        .padding([.bottom], 38)
    }
}
