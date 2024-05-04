//
//  GroupListView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 04.05.2024.
//

import SwiftUI

struct GroupListView: View {
    
    @EnvironmentObject var coordinator: GroupCoordinator
    
    @StateObject private var viewModel = GroupListViewModel(groupService: GroupService())
    
    var body: some View {
        BaseLayout {
            switch viewModel.state {
            case .loading:
                LoadingDots(type: .view)
            default:
                groupList
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchInitialData()
            }
        }
    }
}

extension GroupListView {
    
    private var groupList: some View {
        VStack {
            HStack (alignment: .firstTextBaseline) {
                ViewTitle(title: "Groups")
                
                Spacer()
                
                OperationButton(icon: "envelope.circle.fill") {
                    coordinator.changeSection(to: .invitations)
                }
            }
            
            ScrollView {
                ForEach(viewModel.groups, id: \.id) { group in
                    CommonGroupListRow(
                        name: group.name,
                        variableText: "New notifications: 0",
                        symbol: group.icon
                    ) { EmptyView()}
                }
            }
        }
    }
    
}
