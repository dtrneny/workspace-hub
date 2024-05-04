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
    
    init(accountService: AccountServiceProtocol, groupService: GroupServiceProtocol) {
        self.accountService = accountService
        self.groupService = groupService
    }
    
    @Published var participantAccounts: [Account] = []
    
    func fetchInitialData(groupId: String) async {
        state = .loading
        
        guard let fetchedGroup = await groupService.getGroup(id: groupId) else  {
            state = .idle
            return
        }
        
        let memberIds = fetchedGroup.members.map { groupMember in
            groupMember.id
        }
        
        let fetchedAccounts = await getParticipantAccounts(participantIds: memberIds)
        participantAccounts = fetchedAccounts
        
        state = .idle
    }
    
    func getParticipantAccounts(participantIds: [String]) async -> [Account] {
        guard !participantIds.isEmpty else {
            return []
        }
        
        return await accountService.getAccounts(assembleQuery: { query in
            query.whereField(FieldPath.documentID(), in: participantIds)
        })
    }
}
