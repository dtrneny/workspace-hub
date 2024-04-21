//
//  GroupAdditionView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 21.04.2024.
//

import SwiftUI

struct GroupAdditionView: View {
    
    @Binding var isPresented: Bool
    @EnvironmentObject var coordinator: GroupCoordinator
    @StateObject private var viewModel = GroupAdditionViewModel(groupService: GroupService())
    
    var body: some View {
        SheetLayout {
            ViewTitle(title: "Add group")
            
            formView
            
            Button("Create group") {
                Task {
                    if(await viewModel.createGroup()) {
                        isPresented = false
                    }
                }
            }.filledButtonStyle()
        }
    }
}

extension GroupAdditionView {
    
    private var formView: some View {
        VStack(spacing: 19) {
            FormField {
                TextInput(
                    value: $viewModel.groupName,
                    placeholder: "Group name",
                    label: "Name"
                )
                if let error = viewModel.groupNameError {
                    ErrorMessage(error: error)
                }
            }
        }
        .padding(.bottom, 38)
    }
}
