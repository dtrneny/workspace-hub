//
//  AddWorkspaceSheet.swift
//  workspace-hub
//
//  Created by František on 18.04.2024.
//

import SwiftUI

struct AddWorkspaceSheet: View {
    @Binding var isAddingItemSheetPresented: Bool
    
    @StateObject private var viewModel = WorkspaceListViewModel(workspaceService: WorkspaceService())
    
    var body: some View {
        BaseLayout {
            VStack(alignment: .leading, spacing: 20) {
                Text("Add workspace")
                    .foregroundColor(.secondary900)
                    .font(.inter(30.0))
                    .fontWeight(.bold)
                    .padding([.bottom], 38)
                
                formView
                
                Button("Create workspace") {
                    Task {
                        await viewModel.createWorkspace()
                        isAddingItemSheetPresented = false
                    }
                }.filledButtonStyle()
            }
        }
        .padding(20)
    }
}

extension AddWorkspaceSheet {
    
    private var formView: some View {
        VStack(spacing: 19) {
            TextInput(
                fieldValue: $viewModel.name,
                placeholder: "Your workspace",
                label: "Name"
            )
            TextInput(
                fieldValue: $viewModel.icon,
                placeholder: "heart",
                label: "Icon"
            )
        }
        .padding(.bottom, 38)
    }
}

#Preview {
    AddWorkspaceSheet(isAddingItemSheetPresented: .constant(true))
}
