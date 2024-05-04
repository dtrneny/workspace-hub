//
//  ParticipantListView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 04.05.2024.
//

import SwiftUI

struct MemberListView: View {
    
    let groupId: String
    
    let navigateToInvitation: (_ groupId: String) -> Void

    
    @StateObject private var viewModel = MemberListViewModel(
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

extension MemberListView {
    
    private var memberList: some View {
        VStack(alignment: .leading) {
            HStack (alignment: .firstTextBaseline) {
                ViewTitle(title: "Group members")
                
                Spacer()
                
                OperationButton(icon: "plus") {
                    navigateToInvitation(groupId)
                }
            }
            
            ScrollView {
                ForEach(viewModel.participantAccounts, id: \.id) { account in
                    Text(account.email)
                        .foregroundStyle(.secondary900)
                }
            }
        }
    }
    
}
