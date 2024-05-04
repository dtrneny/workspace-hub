//
//  WorkspaceAdministrator.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 04.05.2024.
//

import Foundation

struct WorkspaceAdministrator: Identifiable, Codable {
    var id: String
    var role: WorkspaceAdministratorType
}
