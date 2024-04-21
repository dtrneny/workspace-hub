//
//  WorkspaceListView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import SwiftUI

struct WorkspaceListView: View {
    
    @State private var selectedOption: Int = 0
    @EnvironmentObject var coordinator: WorkspaceCoordinator
    @StateObject private var viewModel = WorkspaceListViewModel(workspaceService: WorkspaceService())
    
    
    var body: some View {
        BaseLayout {
            VStack(spacing: 38) {
                VStack(alignment: .leading) {
                    ViewTitle(title: "Newest message")
                    WorkspaceActivityCard (
                        title: "Naomi Foo",
                        text: "Hey there! Just wanted to touch base and say thanks for all your hard  work on editing the video. Really appreciate your dedication to making  it...",
                        image: "logo"
                    ) {
                        print("clicked")
                    }
                }
                
                VStack(alignment: .leading) {
                    
                    HStack(alignment: .firstTextBaseline) {
                        ViewTitle(title: "Workspaces")
                        
                        Spacer()
                        
                        OperationButton(icon: "plus") {
                            viewModel.presentAddition.toggle()
                        }
                    }
                    
                    ScrollView {
                        if viewModel.workspaces.isEmpty {
                            Text("There are no workspaces...")
                                .font(.inter(14.0))
                                .padding()
                        } else {
                            ForEach(viewModel.workspaces) { workspace in
                                WorkspaceListRow(title: workspace.name, notificationCount: 5, icon: workspace.icon, imageColor: .primaryRed700)
                            }
                        }
                    }
                }
            }
        }.sheet(isPresented: $viewModel.presentAddition) {
            WorkspaceAdditionView(isPresented: $viewModel.presentAddition)
        }
        .task {
            await viewModel.getWorkspaces()
        }
    }
}

#Preview {
    WorkspaceListView()
}
