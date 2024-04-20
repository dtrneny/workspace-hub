//
//  WorkspaceListViewModel.swift
//  workspace-hub
//
//  Created by František on 18.04.2024.
//

import Foundation
import SwiftUI

final class WorkspaceListViewModel: ViewModelProtocol {
    
    let workspaceService: WorkspaceServiceProtocol
    
    @Published var state: ViewState = .idle
    
    @Validated(rules: [nonEmptyRule])
    var workspaceName: String = ""
    @Published var workspaceNameError: String? = nil
    
    @Validated(rules: [nonEmptyRule])
    var workspaceIcon: String = ""
    @Published var workspaceIconError: String? = nil
    
    @Published var workspaces: [Workspace] = []
    
    init(workspaceService: WorkspaceServiceProtocol) {
        self.workspaceService = workspaceService
    }
    
    func getWorkspaces() async {
        state = .loading
        do {
            workspaces = await workspaceService.getWorkspaces()
            state = .success
        }
    }
    
    func createWorkspace() async {
        
        if (!$workspaceName.isValid() || !$workspaceIcon.isValid()) {
            workspaceNameError = $workspaceName.getError()
            workspaceIconError = $workspaceIcon.getError()
            return
        }
        
        do {
            if let user = AuthService.shared.getCurrentUser()?.uid {
                let newWorkspace = Workspace(ownerId: user, name: workspaceName, icon: workspaceIcon, groups: [])
                
                if let createdWorkspace = await workspaceService.createWorkspace(workspace: newWorkspace) {
                    workspaces.append(createdWorkspace)
                }
            } else {
                print("User is not logged in or user ID is not available")
            }
        }
    }
}
