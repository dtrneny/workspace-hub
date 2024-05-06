//
//  WorkspaceEditView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 26.04.2024.
//

import SwiftUI
import SFSymbolsPicker

struct WorkspaceEditView: View {
    
    var workspaceId: String
    
    @EnvironmentObject var coordinator: WorkspaceCoordinator
    
    @StateObject private var viewModel = WorkspaceEditViewModel(workspaceService: WorkspaceService())
    
    private let pickerTitle = NSLocalizedString("Pick a symbol", comment: "")
    
    var body: some View {
        BaseLayout {
            switch viewModel.state {
            case .loading:
                LoadingDots(type: .view)
            default:
                ViewTitle(title: "Edit workspace")
                
                workspaceImage
                
                formView
                
                VStack (spacing: 19) {
                    createButton
                    
                    deleteButton
                }
            }
        }
        .confirmationDialog(
            "Do you want to remove this workspace?",
            isPresented: $viewModel.deleteConfirmation,
            titleVisibility: .visible
        ) {
            Button("Confirm", role: .destructive) {
                Task {
                    let _ = await viewModel.deleteWorkspace()
                    coordinator.replaceAll(with: [.list])
                }
            }
        }
        .routerBarBackArrowHidden(viewModel.updatingWorkspace || viewModel.deletingWorkspace)
        .onAppear {
            Task {
                await viewModel.fetchInitialData(workspaceId: workspaceId)
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

extension WorkspaceEditView {
    
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
        }
        .padding([.bottom], 38)
    }
    
    private var createButton: some View {
        BaseButton {
            HStack (spacing: 8) {
                if (viewModel.updatingWorkspace) {
                    ProgressView()
                        .tint(.white)
                }
                Text("Update workspace")
                    .font(.inter(16.0))
            }
        }
        .onTapGesture {
            Task {
                if(await viewModel.updateWorkspace()) {
                    coordinator.pop()
                }
            }
        }
    }
    
    private var deleteButton: some View {
        BaseButton(content: {
            Text("Delete workspace")
                .font(.inter(16.0))
        }, style: .danger)
        .onTapGesture {
            viewModel.deleteConfirmation = true
        }
    }
    
    private var workspaceImage: some View {
        VStack(alignment: .center) {
            HStack {
                Spacer()
                    
                ZStack {
                    Circle()
                        .fill(Color(uiColor: viewModel.selectedColor))
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
            
            ThemeColorPicker(selectedColor: $viewModel.selectedColor)
        }
        .padding([.bottom], 19)
    }
}
