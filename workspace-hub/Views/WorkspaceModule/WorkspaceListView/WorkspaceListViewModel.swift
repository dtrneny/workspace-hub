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
        await getWorkspaces()
        
        state = .idle
    }
    
    func getWorkspaces() async {
        state = .loading
        do {
            workspaces = await workspaceService.getWorkspaces()
            state = .success
        }
    }
}
