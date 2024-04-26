//
//  WorkspaceAdditionViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 20.04.2024.
//

import Foundation
import SwiftUI

final class WorkspaceAdditionViewModel: ViewModelProtocol {
    
    @Published var state: ViewState = .idle
    
    let workspaceService: WorkspaceServiceProtocol
    
    init(workspaceService: WorkspaceServiceProtocol) {
        self.workspaceService = workspaceService
    }
    
    @Published var selectedIcon: String = "person.3.fill"
    @Published var symbolSelectPresented: Bool = false
    @Published var selectedColor: UIColor = UIColor(.primaryRed700)
    @Published var creatingWorkspace: Bool = false

    @Validated(rules: [nonEmptyRule])
    var workspaceName: String = ""
    @Published var workspaceNameError: String? = nil
    
    
    func createWorkspace() async -> Bool {
        if (!$workspaceName.isValid()) {
            workspaceNameError = $workspaceName.getError()
            
            return false
        }
        
        creatingWorkspace = true
        guard let userId = AuthService.shared.getCurrentUser()?.uid else {
            creatingWorkspace = false
            return false
        }
                    
        let newWorkspace = Workspace(ownerId: userId, name: workspaceName, icon: selectedIcon, hexColor: selectedColor.hexString, groups: [])
        
        let _ = await workspaceService.createWorkspace(workspace: newWorkspace)
        
        creatingWorkspace = false
        return true
    }
}
