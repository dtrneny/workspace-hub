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
    
    var body: some View {
        BaseLayout {
            ViewTitle(title: "Edit workspace")
            
            workspaceImage
            
            formView
            
            createButton
            
        }
        .onAppear {
            Task {
                await viewModel.getWorkspace(workspaceId: workspaceId)
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
            Task {
                if(await viewModel.updateWorkspace()) {
                    coordinator.pop()
                }
            }
        } content: {
            HStack (spacing: 8) {
                if (viewModel.updatingWorkspace) {
                    ProgressView()
                        .tint(.white)
                }
                Text("Update workspace")
            }
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
