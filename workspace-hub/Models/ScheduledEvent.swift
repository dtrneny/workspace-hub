//
//  ScheduledEvent.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 06.05.2024.
//

import Foundation
import FirebaseFirestoreSwift

struct ScheduledEvent: Identifiable, Codable {
    @DocumentID var id: String?
    var workspaceId: String
    var groupId: String? = nil
    var userIds: [String] = []
    var startAt: Date
    var endAt: Date
    var title: String
    var description: String? = nil
    var scheduledBy: String
}
