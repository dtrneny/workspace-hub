//
//  GroupAdditionView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 21.04.2024.
//

import SwiftUI

struct GroupAdditionView: View {
    
    @EnvironmentObject var coordinator: GroupCoordinator
    
    @StateObject private var viewModel = GroupAdditionViewModel(
        groupService: GroupService()
    )
    
    @Binding var isPresented: Bool
    
    var body: some View {
        SheetLayout {
            ViewTitle(title: "Add group")
            
            formView
        
            BaseButton {
                Task {
                    if(await viewModel.createGroup()) {
                        isPresented = false
                    }
                }
            } content: {
                Text("Create group")
            }
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
