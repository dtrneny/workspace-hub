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
    @Published var workspaces: [Workspace] = []
    @Published var presentAddition: Bool = false
    
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
}
