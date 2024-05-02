//
//  ChatItem.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 02.05.2024.
//

import Foundation

struct ChatItem: Identifiable {
    var id: String = UUID().uuidString
    var message: Message
    var fromCurrentUser: Bool = false
}
