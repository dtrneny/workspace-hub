//
//  GroupInvitationListViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 04.05.2024.
//

import Foundation
import FirebaseFirestore

final class GroupInvitationListViewModel: ViewModelProtocol {
    
    @Published var state: ViewState = .loading
    
    let invitationService: InvitationServiceProtocol
    let groupService: GroupServiceProtocol
    
    init(invitationService: InvitationServiceProtocol, groupService: GroupServiceProtocol) {
        self.invitationService = invitationService
        self.groupService = groupService
    }
        
    @Published var invitationGroups: [InvitationGroup] = []
    @Published var deleteInvitationConfirmation: Bool = false
    @Published var deletedInvitation: String? = nil
    
    func fetchInitialData() async {
        state = .loading

        
        let fetchedInvitations = await getInvitations()
        let invitationsGroupIds = fetchedInvitations.map { invitation in
            invitation.groupId
        }
        
        let fetchedInvitationGroups = await getGroups(ids: invitationsGroupIds)
        
        let mergedGroups: [InvitationGroup?] = fetchedInvitations.map({ invitation in
            guard let invitationId = invitation.id else {
                return nil
            }
            
            guard let foundGroup = fetchedInvitationGroups.first(where: { group in
                group.id == invitation.groupId
            }) else {
                return nil
            }
            
            return InvitationGroup(group: foundGroup, invitationId: invitationId)
        })
        
        invitationGroups = mergedGroups.compactMap { $0 }
        
        state = .idle
    }
    
    func getGroups(ids: [String]) async -> [Group] {
        guard !ids.isEmpty else {
            return []
        }
                
        return await groupService.getGroups(assembleQuery: { query in
            query.whereField(FieldPath.documentID(), in: ids)
        })
    }
    
    func getInvitations() async -> [Invitation] {
        let user = AuthService.shared.getCurrentUser()
        
        guard let userId = user?.uid else { return [] }
        
        let invitations = await invitationService.getInvitations { query in
            query.whereField("invitedId", isEqualTo: userId)
        }
                
        return invitations
    }
    
    func deleteInvitation() async -> Bool {
        guard let deletedId = deletedInvitation else {
            deleteInvitationConfirmation = false
            return false
        }
        
        let result = await invitationService.deleteInvitation(id: deletedId)
        
        if (result) {
            invitationGroups = invitationGroups.filter{ $0.invitationId != deletedId }
        }
        
        deletedInvitation = nil
        deleteInvitationConfirmation = false
        return result
    }
    
    func acceptInvitation(invitationGroup: InvitationGroup) async -> Bool {
        let user = AuthService.shared.getCurrentUser()
        
        guard let userId = user?.uid else { return false }
        
        var groupUpdate = invitationGroup.group
        
        guard let groupId = groupUpdate.id else {
            return false
        }
        
        groupUpdate.members.append(GroupMember(id: userId, role: .member))
        groupUpdate.memberIds.append(userId)
        
        let groupResult = await groupService.updateGroup(id: groupId, update: groupUpdate)
        
        if (groupResult == nil) { return false }
        
        deletedInvitation = invitationGroup.invitationId
        
        let deletionResult = await deleteInvitation()
        
        return deletionResult
    }
}
