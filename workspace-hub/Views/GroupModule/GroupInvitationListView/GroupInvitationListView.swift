//
//  GroupInvitationListView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 04.05.2024.
//

import SwiftUI

struct GroupInvitationListView: View {
    
    @StateObject private var viewModel = GroupInvitationListViewModel(
        invitationService: InvitationService(),
        groupService: GroupService()
    )
    
    var body: some View {
        BaseLayout {
            switch viewModel.state {
            case .loading:
                LoadingDots(type: .view)
            default:
                invitationList
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
                await viewModel.fetchInitialData()
            }
        }
    }
}

extension GroupInvitationListView {
    
    private var invitationList: some View {
        VStack {
            HStack {
                ViewTitle(title: "Group invitations")
                
                Spacer()
            }
            
            ScrollView {
                ForEach(viewModel.invitationGroups, id: \.id) { invGroup in
                    CommonGroupListRow(
                        name: invGroup.group.name,
                        variableText: "Member count: \(invGroup.group.members.count)",
                        symbol: invGroup.group.icon
                    ) {
                        HStack(spacing: 10) {
                            OperationButton(icon: "trash", color: .primaryRed700) {
                                viewModel.deletedInvitation = invGroup.invitationId
                                viewModel.deleteInvitationConfirmation = true
                            }
                            
                            OperationButton(icon: "checkmark", color: .primaryGreen700) {
                                Task {
                                    await viewModel.acceptInvitation(invitationGroup: invGroup)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
}
