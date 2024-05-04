//
//  GroupEditView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 03.05.2024.
//

import SwiftUI
import SFSymbolsPicker

struct GroupEditView: View {

    let workspaceId: String
    let groupId: String
    
    let navigateToRoot: () -> Void
    let navigateBack: () -> Void
    
    @StateObject private var viewModel = GroupEditViewModel(groupService: GroupService())
    
    var body: some View {
        BaseLayout {
            switch viewModel.state {
            case .loading:
                LoadingDots(type: .view)
            default:
                ViewTitle(title: "Edit group")
                
                workspaceImage
                
                formView
                
                VStack (spacing: 19) {
                    createButton
                    
                    deleteButton
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
            SymbolsPicker(selection:  $viewModel.selectedIcon, title: "Pick a symbol", autoDismiss: true) {
                OperationButton(icon: "multiply") {
                    viewModel.symbolSelectPresented = false
                }
            }
        }
        .preferredColorScheme(.light)
    }
}

extension GroupEditView {
    
    private var formView: some View {
        VStack(spacing: 19) {
            FormField {
                TextInput(
                    value: $viewModel.groupName,
                    placeholder: "Your workspace",
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
            Task {
                if(await viewModel.updateGroup()) {
                    navigateBack()
                }
            }
        } content: {
            HStack (spacing: 8) {
                if (viewModel.updatingGroup) {
                    ProgressView()
                        .tint(.white)
                }
                Text("Update group")
            }
        }
    }
    
    private var deleteButton: some View {
        BaseButton(action: {
            Task {
                let _ = await viewModel.deleteGroup(workspaceId: workspaceId)
                navigateToRoot()
            }
        }, content: {
            HStack (spacing: 8) {
                if (viewModel.deletingGroup) {
                    ProgressView()
                        .tint(.primaryRed700)
                }
                Text("Delete group")
            }
        }, style: .danger)
    }
    
    private var workspaceImage: some View {
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
