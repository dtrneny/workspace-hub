//
//  InvitationAdditionView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 04.05.2024.
//

import SwiftUI

struct InvitationAdditionView: View {
    
    let groupId: String
    
    let navigateBack: () -> Void
    
    @StateObject private var viewModel = InvitationAdditionViewModel(
        accountService: AccountService(),
        invitationService: InvitationService()
    )
    
    var body: some View {
        BaseLayout {
            ViewTitle(title: "Create invitation")
                        
            formView
            
            createButton
            
        }
        .routerBarBackArrowHidden(viewModel.creatingInvitation)
        .preferredColorScheme(.light)
    }
}

extension InvitationAdditionView {
    
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
                    navigateBack()
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
