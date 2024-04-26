//
//  WorkspaceDetailViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 26.04.2024.
//

import Foundation

final class WorkspaceDetailViewModel: ViewModelProtocol {
    
    @Published var state: ViewState = .idle
    
    let workspaceService: WorkspaceServiceProtocol
    
    init(workspaceService: WorkspaceServiceProtocol) {
        self.workspaceService = workspaceService
    }
    
    @Published var workspace: Workspace? = nil
    
    func getWorkspace(workspaceId: String) async {
        state = .loading
        do {
            workspace = await workspaceService.getWorkspace(id: workspaceId)
            state = .success
        }
    }
}
