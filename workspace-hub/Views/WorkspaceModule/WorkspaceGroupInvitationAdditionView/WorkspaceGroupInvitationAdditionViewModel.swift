//
//  WorkspaceGroupInvitationAdditionViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 05.05.2024.
//

import Foundation

final class WorkspaceGroupInvitationAdditionViewModel: ViewModelProtocol {
    
    @Published var state: ViewState = .loading
    
    let accountService: AccountServiceProtocol
    let invitationService: InvitationServiceProtocol
    let groupService: GroupServiceProtocol
    
    init(
        accountService: AccountServiceProtocol,
        invitationService: InvitationServiceProtocol,
        groupService: GroupServiceProtocol
    ) {
        self.accountService = accountService
        self.invitationService = invitationService
        self.groupService = groupService
    }
    
    @Published var creatingInvitation: Bool = false
        
    @Validated(rules: [nonEmptyRule, emailRule])
    var email: String = ""
    @Published var emailError: String? = nil
    
    func inviteMember(groupId: String) async -> Bool{
        if (!$email.isValid()) {
            emailError = $email.getError()
            
            return false
        }
        
        creatingInvitation = true
        
        let matchingAccounts = await accountService.getAccounts { query in
            query.whereField("email", isEqualTo: self.email)
        }
        
        guard let userId = matchingAccounts.first?.id else {
            emailError = NSLocalizedString("User with specified e-mail does not exist.", comment: "")
            creatingInvitation = false
            return false
        }
        
        let group = await groupService.getGroup(id: groupId)
        guard let group = group else {
            creatingInvitation = false
            return false
        }
        
        if (group.members.allSatisfy { $0.id == userId }) {
            emailError = NSLocalizedString("User is already member of group.", comment: "")
            creatingInvitation = false
            return false
        }
        
        let invitationsForGroup = await invitationService.getInvitations { query in
            query.whereField("groupId", isEqualTo: groupId)
        }
        
        let existingInvitations = invitationsForGroup.filter {$0.invitedId == userId }
        
        if (!existingInvitations.isEmpty) { return true }
        
        let result = await invitationService.createInvitation(invitation: Invitation(invitedId: userId, groupId: groupId))
        
        creatingInvitation = false
        return result != nil
    }
}
