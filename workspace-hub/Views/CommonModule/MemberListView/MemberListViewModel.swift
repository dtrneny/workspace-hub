//
//  ParticipantListViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 04.05.2024.
//

import Foundation
import FirebaseFirestore

final class MemberListViewModel: ViewModelProtocol {
    
    @Published var state: ViewState = .loading
    
    let accountService: AccountServiceProtocol
    let groupService: GroupServiceProtocol
    let invitationService: InvitationServiceProtocol
    
    init(
        accountService: AccountServiceProtocol,
        groupService: GroupServiceProtocol,
        invitationService: InvitationServiceProtocol
    ) {
        self.accountService = accountService
        self.groupService = groupService
        self.invitationService = invitationService
    }
    
    @Published var participantAccounts: [Account] = []
    @Published var invitationAccounts: [InvitationAccount] = []
    @Published var ownerMember: GroupMember? = nil
    
    func fetchInitialData(groupId: String) async {
        state = .loading
        
        guard let fetchedGroup = await groupService.getGroup(id: groupId) else  {
            state = .idle
            return
        }
        
        let memberIds = fetchedGroup.members.map { groupMember in
            if(groupMember.role == .owner) {
                ownerMember = groupMember
            }
            
            return groupMember.id
        }
        
        let fetchedAccounts = await getAccounts(ids: memberIds)
        participantAccounts = fetchedAccounts
        
        let fetchedInvitations = await getInvitations(groupId: groupId)
        let invitationsAccountIds = fetchedInvitations.map { invitation in
            invitation.invitedId
        }
        
        let fetchedInvitationAccounts = await getAccounts(ids: invitationsAccountIds)
        
        let mergedAccounts: [InvitationAccount?] = fetchedInvitations.map({ invitation in
            guard let invitationId = invitation.id else {
                return nil
            }
            
            guard let foundAccount = fetchedInvitationAccounts.first(where: { account in
                account.id == invitation.invitedId
            }) else {
                return nil
            }
            
            return InvitationAccount(account: foundAccount, invitationId: invitationId)
        })
        
        invitationAccounts = mergedAccounts.compactMap { $0 }
        
        state = .idle
    }
    
    func getAccounts(ids: [String]) async -> [Account] {
        guard !ids.isEmpty else {
            return []
        }
        
        return await accountService.getAccounts(assembleQuery: { query in
            query.whereField(FieldPath.documentID(), in: ids)
        })
    }
    
    func getInvitations(groupId: String) async -> [Invitation] {
        return await invitationService.getInvitations(assembleQuery: { query in
            query.whereField("groupId", isEqualTo: groupId)
        })
    }
    
    func deleteInvitation(id: String) async -> Bool {
        let result = await invitationService.deleteInvitation(id: id)
        
        if (result) {
            invitationAccounts = invitationAccounts.filter{ $0.invitationId != id }
        }
        
        return result
    }
}
