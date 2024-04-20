//
//  AddGroupSheet.swift
//  workspace-hub
//
//  Created by František on 19.04.2024.
//

//
//  AddWorkspaceSheet.swift
//  workspace-hub
//
//  Created by František on 18.04.2024.
//

import SwiftUI

struct AddGroupSheet: View {
    @Binding var isAddingItemSheetPresented: Bool
    
    @StateObject private var viewModel = GroupListViewModel(groupService: GroupService())
    
    var body: some View {
        BaseLayout {
            VStack(alignment: .leading, spacing: 20) {
                Text("Add group")
                    .foregroundColor(.secondary900)
                    .font(.inter(30.0))
                    .fontWeight(.bold)
                    .padding([.bottom], 38)
                
                formView
                
                Button("Create group") {
                    Task {
                        await viewModel.createGroup()
                        isAddingItemSheetPresented = false
                    }
                }.filledButtonStyle()
            }
        }
        .padding(20)
    }
}

extension AddGroupSheet {
    
    private var formView: some View {
        VStack(spacing: 19) {
            TextInput(
                value: $viewModel.groupName,
                placeholder: "Your workspace",
                label: "Name"
            )
            if let error = viewModel.groupNameError {
                ErrorMessage(error: error)
            }
        }
        .padding(.bottom, 38)
    }
}

#Preview {
    AddGroupSheet(isAddingItemSheetPresented: .constant(true))
}
