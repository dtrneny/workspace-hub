//
//  GroupListView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import SwiftUI

struct GroupListView: View {
    
    @EnvironmentObject var coordinator: GroupCoordinator
    
    @StateObject private var viewModel = GroupListViewModel(groupService: GroupService())
        
    var body: some View {
        BaseLayout {
            VStack {
                HStack(alignment: .firstTextBaseline) {
                    ViewTitle(title: "Groups")
                    
                    Spacer()
                    
                    OperationButton(icon: "plus") {
                        viewModel.presentAddition.toggle()
                    }
                }
                
                if viewModel.groups.isEmpty {
                    Text("You are not part of any groups yet...")
                        .font(.inter(14.0))
                        .padding()
                } else {
                    ScrollView {
                        ForEach(viewModel.groups) { group in
                            GroupListRow(title: group.name, notificationCount: 5)
                        }
                    }
                }
                
            }
        }.sheet(isPresented: $viewModel.presentAddition) {
            GroupAdditionView(isPresented: $viewModel.presentAddition)
        }
        .task {
            await viewModel.getGroupsOfCurrentUser()
        }
    }
}

#Preview {
    GroupListView()
}
