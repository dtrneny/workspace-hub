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
    var name: String
    var icon: String
    var members: [GroupMember]
    var events: [Date]
}
