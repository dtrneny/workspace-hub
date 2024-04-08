//
//  Workspace.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 07.04.2024.
//

import Foundation
import FirebaseFirestoreSwift

struct Workspace: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var ownerId: String
    var name: String
    var icon: String
}
