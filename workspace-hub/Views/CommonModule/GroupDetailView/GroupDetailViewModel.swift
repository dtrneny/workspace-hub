//
//  GroupDetailViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 02.05.2024.
//

import Foundation

final class GroupDetailViewModel: ViewModelProtocol {
    
    @Published var state: ViewState = .loading
    
    let groupService: GroupServiceProtocol
    
    init(groupService: GroupServiceProtocol) {
        self.groupService = groupService
    }
    
    @Published var group: Group? = nil
    @Published var isUserOwner: Bool = false
    
    func fetchInitialData(groupId: String) async {
        state = .loading
                
        guard let fetchedGroup = await getGroup(groupId: groupId) else  {
            state = .error(message: "Group not found.")
            return
        }
        
        group = fetchedGroup
                
        if let userId = AuthService.shared.getCurrentUser()?.uid {
            isUserOwner = userId == fetchedGroup.ownerId
        }
                
        state = .idle
    }
    
    func getGroup(groupId: String) async -> Group? {
        let group = await groupService.getGroup(id: groupId)
        return group
    }
}
