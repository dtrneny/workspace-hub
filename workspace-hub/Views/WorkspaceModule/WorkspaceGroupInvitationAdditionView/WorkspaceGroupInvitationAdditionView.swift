//
//  WorkspaceGroupInvitationAdditionView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 05.05.2024.
//

import SwiftUI

struct WorkspaceGroupInvitationAdditionView: View {
    
    let groupId: String
    
    @EnvironmentObject var coordinator: WorkspaceCoordinator
        
    @StateObject private var viewModel = WorkspaceGroupInvitationAdditionViewModel(
        accountService: AccountService(),
        invitationService: InvitationService(),
        groupService: GroupService()
    )
    
    var body: some View {
        BaseLayout {
            ViewTitle(title: "Create invitation")
                        
            formView
            
            createButton
            
        }
        .routerBarBackArrowHidden(viewModel.creatingInvitation)
    }
}

extension WorkspaceGroupInvitationAdditionView {
    
    private var formView: some View {
        VStack(spacing: 19) {
            FormField {
                TextInput(
                    value: $viewModel.email,
                    placeholder: "e. g. john.doe@email.com",
                    label: "E-mail"
                )
                if let error = viewModel.emailError {
                    ErrorMessage(error: error)
                }
            }
        }
        .padding([.bottom], 38)
    }
    
    private var createButton: some View {
        BaseButton {
            Task {
                if(await viewModel.inviteMember(groupId: groupId)) {
                    coordinator.pop()
                }
            }
        } content: {
            HStack (spacing: 8) {
                if (viewModel.creatingInvitation) {
                    ProgressView()
                        .tint(.white)
                }
                Text("Invite member")
            }
        }
    }
}
