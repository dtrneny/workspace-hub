//
//  InvitationGroup.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 04.05.2024.
//

import Foundation

struct InvitationGroup: Identifiable {
    var id: String = UUID().uuidString
    var group: Group
    var invitationId: String
}

