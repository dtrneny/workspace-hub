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
    
    @State private var isAddingItemSheetPresented = false
    
    var body: some View {
        BaseLayout {
            VStack(spacing: 38) {
                VStack(alignment: .leading) {
                    ViewTitle(title: "Newest message")
                    WorkspaceAcitvityCard (
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
                            isAddingItemSheetPresented.toggle()
                        }
                    }
                    
                    ScrollView {
                        if viewModel.workspaces.isEmpty {
                            Text("Loading...")
                                .padding()
                        } else {
                            ForEach(viewModel.workspaces) { workspace in
                                WorkspaceListRow(title: workspace.name, notificationCount: 5, icon: workspace.icon, imageColor: .primaryRed700)
                            }
                        }
                    }
                }
            }
        }.sheet(isPresented: $isAddingItemSheetPresented) {
            AddWorkspaceSheet(isAddingItemSheetPresented: $isAddingItemSheetPresented)
        }
        .task {
            await viewModel.getWorkspaces()
        }
    }
}

#Preview {
    WorkspaceListView()
}
