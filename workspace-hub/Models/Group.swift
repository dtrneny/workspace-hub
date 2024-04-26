//
//  Group.swift
//  workspace-hub
//
//  Created by František on 19.04.2024.
//

import Foundation
import FirebaseFirestoreSwift

struct Group: Identifiable, Codable {
    @DocumentID var id: String?
    var ownerId: String
    var name: String
    var members: [String]
    var events: [Date]
}
