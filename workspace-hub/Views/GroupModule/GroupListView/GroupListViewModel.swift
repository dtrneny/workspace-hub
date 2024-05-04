//
//  GroupListViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 04.05.2024.
//

import Foundation

final class GroupListViewModel: ViewModelProtocol {
    
    @Published var state: ViewState = .loading
    
    let groupService: GroupServiceProtocol
    
    init(groupService: GroupServiceProtocol) {
        self.groupService = groupService
    }
        
    @Published var groups: [Group] = []
    
    func fetchInitialData() async {
        state = .loading

        groups = await getGroups()
        
        state = .idle
    }
    
    func getGroups() async -> [Group] {
        let user = AuthService.shared.getCurrentUser()
        
        guard let userId = user?.uid else { return [] }
                
        return await groupService.getGroups { query in
            query.whereField("memberIds", arrayContains: userId)
        }
    }
}
