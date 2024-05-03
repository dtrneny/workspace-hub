//
//  ChatItemGroup.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 03.05.2024.
//

import Foundation

struct ChatItemGroup: Identifiable {
    var id: String = UUID().uuidString
    var chatItems: [ChatItem]
    var isRecieved: Bool = false
}
