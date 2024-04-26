//
//  WorkspaceDetailViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 26.04.2024.
//

import Foundation
import SwiftUI

class WorkspaceDetailViewModel: ViewModelProtocol {
    
    let workspaceService: WorkspaceServiceProtocol
    
    @Published var state: ViewState = .idle
    @Published var workspace: Workspace? = nil
    
    init(workspaceService: WorkspaceServiceProtocol) {
        self.workspaceService = workspaceService
    }
    
    func getWorkspace(workspaceId: String) async {
        state = .loading
        do {
            workspace = await workspaceService.getWorkspace(id: workspaceId)
            state = .success
        }
    }
}
