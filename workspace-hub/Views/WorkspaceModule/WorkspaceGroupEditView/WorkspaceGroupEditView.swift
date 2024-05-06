//
//  WorkspaceGroupEditView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 05.05.2024.
//

import SwiftUI
import SFSymbolsPicker

struct WorkspaceGroupEditView: View {
    
    let workspaceId: String
    let groupId: String
    
    @EnvironmentObject var coordinator: WorkspaceCoordinator
    
    @StateObject private var viewModel = WorkspaceGroupEditViewModel(groupService: GroupService())
    
    private let pickerTitle = NSLocalizedString("Pick a symbol", comment: "")
    
    var body: some View {
        BaseLayout {
            switch viewModel.state {
            case .loading:
                LoadingDots(type: .view)
            default:
                ViewTitle(title: "Edit group")
                
                groupImage
                
                formView
                
                VStack (spacing: 19) {
                    createButton
                    
                    deleteButton
                }
            }
        }
        .confirmationDialog(
            "Do you want to remove this group?",
            isPresented: $viewModel.deleteConfirmation,
            titleVisibility: .visible
        ) {
            Button("Confirm", role: .destructive) {
                Task {
                    let _ = await viewModel.deleteGroup(workspaceId: workspaceId)
                    coordinator.replaceAll(with: [.detail(id: workspaceId)])
                }
            }
        }
        .routerBarBackArrowHidden(viewModel.updatingGroup || viewModel.deletingGroup)
        .onAppear {
            Task {
                await viewModel.fetchInitialData(groupId: groupId)
            }
        }
        .sheet(isPresented: $viewModel.symbolSelectPresented) {
            SymbolsPicker(selection:  $viewModel.selectedIcon, title: pickerTitle, autoDismiss: true) {
                OperationButton(icon: "multiply") {
                    viewModel.symbolSelectPresented = false
                }
            }
        }
        .preferredColorScheme(.light)
    }
}

extension WorkspaceGroupEditView {
    
    private var formView: some View {
        VStack(spacing: 19) {
            FormField {
                TextInput(
                    value: $viewModel.groupName,
                    placeholder: "Your group name",
                    label: "Name"
                )
                if let error = viewModel.groupNameError {
                    ErrorMessage(error: error)
                }
            }
        }
        .padding([.bottom], 38)
    }
    
    private var createButton: some View {
        BaseButton {
            HStack (spacing: 8) {
                if (viewModel.updatingGroup) {
                    ProgressView()
                        .tint(.white)
                }
                Text("Update group")
                    .font(.inter(16.0))
            }
        }
        .onTapGesture {
            Task {
                if(await viewModel.updateGroup()) {
                    coordinator.pop()
                }
            }
        }
    }
    
    private var deleteButton: some View {
        BaseButton(content: {
            Text("Delete group")
                .font(.inter(16.0))
        }, style: .danger)
        .onTapGesture {
            viewModel.deleteConfirmation = true
        }
    }
    
    private var groupImage: some View {
        VStack(alignment: .center) {
            HStack {
                Spacer()
                    
                ZStack {
                    Circle()
                        .fill(.grey300)
                        .frame(width: 125, height: 125)
                    
                    Image(systemName: viewModel.selectedIcon)
                        .font(.system(size: 48))
                }
                .padding([.bottom], 8)
                .onTapGesture {
                    viewModel.symbolSelectPresented = true
                }
                
                Spacer()
            }
        }
        .padding([.bottom], 19)
    }
}
