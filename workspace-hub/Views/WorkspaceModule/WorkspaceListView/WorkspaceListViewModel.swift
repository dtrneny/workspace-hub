//
//  WorkspaceListViewModel.swift
//  workspace-hub
//
//  Created by František on 18.04.2024.
//

import Foundation

final class WorkspaceListViewModel: ViewModelProtocol {
    
    @Published var state: ViewState = .loading
    
    let workspaceService: WorkspaceServiceProtocol
    
    init(workspaceService: WorkspaceServiceProtocol) {
        self.workspaceService = workspaceService
    }
    
    @Published var workspaces: [Workspace] = []
    @Published var presentAddition: Bool = false
    
    func fetchInitialData() async {
        state = .loading
        
        await getWorkspaces()
        
        state = .idle
    }
    
    func getWorkspaces() async {
        guard let userId = AuthService.shared.getCurrentUser()?.uid else {
            return
        }
        
        workspaces = await workspaceService.getWorkspaces(assembleQuery: { query in
            query.whereField("ownerId", isEqualTo: userId)
        })
    }
}
