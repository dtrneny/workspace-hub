//
//  GroupAdditionView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 21.04.2024.
//

import SwiftUI
import SFSymbolsPicker

struct WorkspaceGroupAdditionView: View {
    
    var workspaceId: String
    
    @EnvironmentObject var coordinator: WorkspaceCoordinator
    
    @StateObject private var viewModel = WorkspaceGroupAdditionViewModel(
        groupService: GroupService(),
        workspaceService: WorkspaceService()
    )
        
    var body: some View {
        BaseLayout {
            ViewTitle(title: "Add group")
            
            groupImage
            
            formView
            
            createButton
            
        }
        .onAppear {
            Task {
                await viewModel.fetchInitialData(workspaceId: workspaceId)
            }
        }
        .routerBarBackArrowHidden(viewModel.creatingGroup)
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

extension WorkspaceGroupAdditionView {
    
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
    
    private var createButton: some View {
        BaseButton {
            Task {
                if(await viewModel.createGroup(workspaceId: workspaceId)) {
                    coordinator.pop()
                }
            }
        } content: {
            HStack (spacing: 8) {
                if (viewModel.creatingGroup) {
                    ProgressView()
                        .tint(.white)
                }
                Text("Create group")
            }
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
