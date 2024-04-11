//
//  WorkspacesViewModel.swift
//  workspace-hub
//
//  Created by František on 11.04.2024.
//

import Foundation

class WorkspacesViewModel: ViewModelProtocol {
    
    @Published var state: ViewState = .idle
    @Published var workspacesList: [Workspace] = []
    
}
