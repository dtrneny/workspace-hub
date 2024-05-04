//
//  InvitationAccount.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 04.05.2024.
//

import Foundation

struct InvitationAccount: Identifiable {
    var id: String = UUID().uuidString
    var account: Account
    var invitationId: String
}
