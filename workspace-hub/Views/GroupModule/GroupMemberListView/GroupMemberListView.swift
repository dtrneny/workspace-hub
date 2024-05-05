//
//  GroupMemberListView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 05.05.2024.
//

import SwiftUI

struct GroupMemberListView: View {

    let groupId: String
    
    @EnvironmentObject var coordinator: WorkspaceCoordinator
    
    @StateObject private var viewModel = GroupMemeberListViewModel(
        accountService: AccountService(),
        groupService: GroupService()
    )
    
    var body: some View {
        BaseLayout {
            switch viewModel.state {
            case .loading:
                LoadingDots(type: .view)
            default:
                VStack(spacing: 38) {
                    administratorList
                    
                    memberList
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchInitialData(groupId: groupId)
            }
        }
    }
}

extension GroupMemberListView {
    
    private var administratorList: some View {
        VStack(alignment: .leading) {
            HStack (alignment: .firstTextBaseline) {
                ViewTitle(title: "Group administrators")
                
                Spacer()
            }
            
            ScrollView {
                ForEach(viewModel.administratorAccounts, id: \.id) { account in
                    CommonAccountListRow(
                        name: "\(account.firstname) \(account.lastname)",
                        email: account.email,
                        imageUrl: account.profileImage
                    ) { EmptyView() }
                }
            }
        }
    }
    
    private var memberList: some View {
        VStack(alignment: .leading) {
            HStack (alignment: .firstTextBaseline) {
                ViewTitle(title: "Group members")
                
                Spacer()
            }
            
            ScrollView {
                ForEach(viewModel.memberAccounts, id: \.id) { account in
                    CommonAccountListRow(
                        name: "\(account.firstname) \(account.lastname)",
                        email: account.email,
                        imageUrl: account.profileImage
                    ) { EmptyView() }
                }
            }
        }
    }
}

