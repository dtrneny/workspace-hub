//
//  WorkspaceDetailViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 26.04.2024.
//

import Foundation

final class WorkspaceDetailViewModel: ViewModelProtocol {
    
    @Published var state: ViewState = .loading
    
    let workspaceService: WorkspaceServiceProtocol
    
    init(workspaceService: WorkspaceServiceProtocol) {
        self.workspaceService = workspaceService
    }
    
    @Published var workspace: Workspace? = nil
    
    func fetchInitialData(workspaceId: String) async {
        await getWorkspace(workspaceId: workspaceId)
        
        state = .idle
    }
    
    func getWorkspace(workspaceId: String) async {
        state = .loading
        do {
            workspace = await workspaceService.getWorkspace(id: workspaceId)
            state = .success
        }
    }
}
