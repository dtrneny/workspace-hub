//
//  GroupMember.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 04.05.2024.
//

import Foundation

struct GroupMember: Identifiable, Codable {
    var id: String
    var role: GroupMemberType
}
