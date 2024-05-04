//
//  InvitationAdditionViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 04.05.2024.
//

import Foundation
//import FirebaseFirestore

final class InvitationAdditionViewModel: ViewModelProtocol {
    
    @Published var state: ViewState = .loading
    
    let accountService: AccountServiceProtocol
    let invitationService: InvitationService
    
    init(accountService: AccountServiceProtocol, invitationService: InvitationService) {
        self.accountService = accountService
        self.invitationService = invitationService
    }
    
    @Published var creatingInvitation: Bool = false
        
    @Validated(rules: [nonEmptyRule])
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
            emailError = "User with specified e-mail does not exist."
            creatingInvitation = false
            return false
        }
        
        let inivtationsForGroup = await invitationService.getInvitations { query in
            query.whereField("groupId", isEqualTo: groupId)
        }
        
        let existingInvitations = inivtationsForGroup.filter {$0.invitedId == userId }
        
        if (!existingInvitations.isEmpty) { return true }
        
        let result = await invitationService.createInvitation(invitation: Invitation(invitedId: userId, groupId: groupId))
        
        creatingInvitation = false
        return result != nil
    }
}
