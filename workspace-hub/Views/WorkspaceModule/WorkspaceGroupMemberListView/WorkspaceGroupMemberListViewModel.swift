//
//  WorkspaceGroupMemberListViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 05.05.2024.
//

import Foundation
import FirebaseFirestore

final class WorkspaceGroupMemberListViewModel: ViewModelProtocol {
    
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
    @Published var deleteInvitationConfirmation: Bool = false
    @Published var deletedInvitation: String? = nil
    
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
        
        await prefetchImages()
        
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
    
    func prefetchImages() async {
        let participantAccountPhotos = participantAccounts.map { account in
            account.profileImage
        }
        
        let invitationAccountPhotos = invitationAccounts.map { invAccount in
            invAccount.account.profileImage
        }
        
        await ImageUtil.loadImagesFromUrlsAsync(imageUrls: participantAccountPhotos)
        await ImageUtil.loadImagesFromUrlsAsync(imageUrls: invitationAccountPhotos)
    }
    
    func deleteInvitation() async -> Bool {
        guard let invitationId = deletedInvitation else {
            deleteInvitationConfirmation = false
            return false
        }
        
        let result = await invitationService.deleteInvitation(id: invitationId)
        
        if (result) {
            invitationAccounts = invitationAccounts.filter{ $0.invitationId != invitationId }
        }
        
        deleteInvitationConfirmation = false
        deletedInvitation = nil
        return result
    }
}
