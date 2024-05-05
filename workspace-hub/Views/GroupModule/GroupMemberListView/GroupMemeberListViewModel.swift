//
//  GroupMemeberListViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 05.05.2024.
//

import Foundation
import FirebaseFirestore

final class GroupMemeberListViewModel: ViewModelProtocol {
    
    @Published var state: ViewState = .loading
    
    let accountService: AccountServiceProtocol
    let groupService: GroupServiceProtocol
    
    init(
        accountService: AccountServiceProtocol,
        groupService: GroupServiceProtocol
    ) {
        self.accountService = accountService
        self.groupService = groupService
    }
    
    @Published var memberAccounts: [Account] = []
    @Published var administratorAccounts: [Account] = []

    func fetchInitialData(groupId: String) async {
        state = .loading
        
        guard let fetchedGroup = await groupService.getGroup(id: groupId) else  {
            state = .idle
            return
        }
        
        let memberIds = fetchedGroup.members
            .filter({ $0.role == .member })
            .map { member in member.id }
        
        let adminIds = fetchedGroup.members
            .filter({ $0.role == .owner })
            .map { admin in admin.id }
        
        memberAccounts = await getAccounts(ids: memberIds)
        administratorAccounts = await getAccounts(ids: adminIds)
        
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
}
