//
//  Message.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 02.05.2024.
//

import Foundation
import FirebaseFirestoreSwift

struct Message: Identifiable, Codable {
    @DocumentID var id: String?
    var userId: String
    var text: String
    var sentAt: Date
}
