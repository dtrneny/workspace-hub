//
//  Workspace.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 07.04.2024.
//

import Foundation
import FirebaseFirestoreSwift

struct Workspace: Identifiable, Codable {
    @DocumentID var id: String?
    var ownerId: String
    var administrators: [WorkspaceAdministrator]
    var name: String
    var icon: String
    var hexColor: String?
    var groups: [String]
}
