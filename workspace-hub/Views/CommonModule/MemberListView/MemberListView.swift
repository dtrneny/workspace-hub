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
        groupService: GroupService(),
        invitationService: InvitationService()
    )
    
    var body: some View {
        BaseLayout {
            switch viewModel.state {
            case .loading:
                LoadingDots(type: .view)
            default:
                VStack(spacing: 38) {
                    memberList
                    
                    if (viewModel.ownerMember != nil && !viewModel.invitationAccounts.isEmpty) {
                        invitationList
                    }
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
                    CommonAccountListRow(
                        name: "\(account.firstname) \(account.lastname)",
                        email: account.email,
                        imageUrl: account.profileImage
                    ) {
                        if let owner = viewModel.ownerMember {
                            if (owner.id != account.id) {
                                OperationButton(icon: "multiply", color: .primaryRed700) {
                                    print("remove")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private var invitationList: some View {
        VStack(alignment: .leading) {
            ViewTitle(title: "Group invitations")

            ScrollView {
                ForEach(viewModel.invitationAccounts, id: \.id) { invAccount in
                    CommonAccountListRow(
                        name: "\(invAccount.account.firstname) \(invAccount.account.lastname)",
                        email: invAccount.account.email,
                        imageUrl: invAccount.account.profileImage
                    ) {
                        OperationButton(icon: "location.slash.fill", color: .primaryRed700) {
                            Task {
                               await viewModel.deleteInvitation(id: invAccount.invitationId)
                            }
                        }
                    }
                }
            }
        }
    }
}
