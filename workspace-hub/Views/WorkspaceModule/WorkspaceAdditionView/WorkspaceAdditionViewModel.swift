//
//  WorkspaceAdditionViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 20.04.2024.
//

import Foundation

final class WorkspaceAdditionViewModel: ViewModelProtocol {
    
    let workspaceService: WorkspaceServiceProtocol
    
    @Published var state: ViewState = .idle
    @Published var selectedIcon: String = "pencil"
    
    @Validated(rules: [nonEmptyRule])
    var workspaceName: String = ""
    @Published var workspaceNameError: String? = nil
    
    @Validated(rules: [nonEmptyRule])
    var workspaceIcon: String = ""
    @Published var workspaceIconError: String? = nil
    
    init(workspaceService: WorkspaceServiceProtocol) {
        self.workspaceService = workspaceService
    }
    
    func createWorkspace() async -> Bool {
        if (!$workspaceName.isValid() || !$workspaceIcon.isValid()) {
            workspaceNameError = $workspaceName.getError()
            workspaceIconError = $workspaceIcon.getError()
            
            return false
        }
        
        guard let userId = AuthService.shared.getCurrentUser()?.uid else {
            return false
        }
                    
        let newWorkspace = Workspace(ownerId: userId, name: workspaceName, icon: workspaceIcon, groups: [])
        
        let _ = await workspaceService.createWorkspace(workspace: newWorkspace)
        return true
    }
}
