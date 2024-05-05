//
//  WorkspaceGroupMemberListView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 05.05.2024.
//

import SwiftUI

struct WorkspaceGroupMemberListView: View {
    
    let groupId: String
    
    @EnvironmentObject var coordinator: WorkspaceCoordinator
    
    @StateObject private var viewModel = WorkspaceGroupMemberListViewModel(
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
        .confirmationDialog(
            "Do you want to remove this invitation?",
            isPresented: $viewModel.deleteInvitationConfirmation,
            titleVisibility: .visible
        ) {
            Button("Confirm", role: .destructive) {
                Task {
                   await viewModel.deleteInvitation()
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

extension WorkspaceGroupMemberListView {
    
    private var memberList: some View {
        VStack(alignment: .leading) {
            HStack (alignment: .firstTextBaseline) {
                ViewTitle(title: "Group members")
                
                Spacer()
                
                OperationButton(icon: "plus") {
                    coordinator.changeSection(to: .memberInvitation(groupId: groupId))
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
                            viewModel.deletedInvitation = invAccount.invitationId
                            viewModel.deleteInvitationConfirmation = true
                        }
                    }
                }
            }
        }
    }
}
