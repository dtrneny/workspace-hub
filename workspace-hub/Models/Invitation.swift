//
//  GroupInvitation.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 04.05.2024.
//

import Foundation
import FirebaseFirestoreSwift

struct Invitation: Identifiable, Codable {
    @DocumentID var id: String?
    var invitedId: String
    var groupId: String
}
