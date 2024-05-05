//
//  GroupGeneralViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 05.05.2024.
//

import Foundation

final class GroupGeneralViewModel: ViewModelProtocol {
    
    @Published var state: ViewState = .loading
    
    let groupService: GroupServiceProtocol
    
    init(groupService: GroupServiceProtocol) {
        self.groupService = groupService
    }
        
    @Published var group: Group? = nil
    @Published var leavingGroup: Bool = false
    @Published var leaveConfirmation: Bool = false
    
    func fetchInitialData(groupId: String) async {
        state = .loading

        group = await getGroup(groupId: groupId)
        
        state = .idle
    }
    
    func getGroup(groupId: String) async -> Group? {
        return await groupService.getGroup(id: groupId)
    }
    
    func leaveGroup(groupId: String) async -> Bool {
        let user = AuthService.shared.getCurrentUser()
        
        guard let userId = user?.uid else { return false }
        
        guard let group = group else {
            return false
        }
        
        leavingGroup = true
        
        let newMembers = group.members.filter{ $0.id != userId }
        let newMemberIds = group.memberIds.filter{ $0 != userId }
        let update = Group(name: group.name, icon: group.icon, members: newMembers, memberIds: newMemberIds, events: group.events)
        
        let result = await groupService.updateGroup(id: groupId, update: update)
        
        leavingGroup = true
        leaveConfirmation = false
        return result != nil
    }
}
