//
//  WorkspaceEditViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 26.04.2024.
//

import Foundation
import SwiftUI

final class WorkspaceEditViewModel: ViewModelProtocol {
    
    @Published var state: ViewState = .loading
    
    let workspaceService: WorkspaceServiceProtocol
    
    init(workspaceService: WorkspaceServiceProtocol) {
        self.workspaceService = workspaceService
    }
        
    @Published var selectedIcon: String = "person.3.fill"
    @Published var symbolSelectPresented: Bool = false
    @Published var selectedColor: UIColor = UIColor(.primaryRed700)
    @Published var updatingWorkspace: Bool = false
    @Published var deletingWorkspace: Bool = false
    
    var workspace: Workspace? = nil

    @Validated(rules: [nonEmptyRule])
    var workspaceName: String = ""
    @Published var workspaceNameError: String? = nil
    
    func fetchInitialData(workspaceId: String) async {
        await getWorkspace(workspaceId: workspaceId)
        
        state = .idle
    }
    
    func getWorkspace(workspaceId: String) async {
        if let result = await workspaceService.getWorkspace(id: workspaceId) {
            workspace = result
            selectedIcon = result.icon
            if let hex = result.hexColor {
                selectedColor = HexColorsUtil.getUIColorByHexString(hexString: hex)
            }
            workspaceName = result.name
        }
    }
    
    func deleteWorkspace() async -> Bool {
        if let workspace = workspace {
            deletingWorkspace = true
            return await DeletionService().deleteWorkspace(workspace: workspace)
        }
        
        deletingWorkspace = false
        return false
    }
    
    func updateWorkspace() async -> Bool {
        if (!$workspaceName.isValid()) {
            workspaceNameError = $workspaceName.getError()
            
            return false
        }
        
        updatingWorkspace = true
        
        guard let fetchedWorkspace = workspace else {
            updatingWorkspace = false
            return false
        }
        
        guard let workspaceId =  fetchedWorkspace.id else {
            updatingWorkspace = false
            return false
        }
        
        let update = Workspace(ownerId: fetchedWorkspace.ownerId, name: workspaceName, icon: selectedIcon, hexColor: selectedColor.hexString, groups: fetchedWorkspace.groups)
                        
        let _ = await workspaceService.updateWorkspace(id: workspaceId, update: update)
        
        updatingWorkspace = false
        return true
    }
}
