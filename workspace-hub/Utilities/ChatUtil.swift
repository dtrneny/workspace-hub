//
//  ChatItemUtil.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 03.05.2024.
//

import Foundation

final class ChatUtil {
    
    static func getChatItemsFromMessages(messages: [Message], currentUserId: String? = nil) -> [ChatItem] {
        let sortedMessages = messages.sorted { message1, message2 in
            message1.sentAt < message2.sentAt
        }
        
        let chatItems = sortedMessages.map { message in
            let currentUser = message.userId == currentUserId
            return ChatItem(message: message, isRecieved: currentUser)
        }
        
        return chatItems
    }
    
    static func getChatItemGroupsFromMessages(messages: [Message], currentUserId: String? = nil) -> [ChatItemGroup] {
        var chatItemGroups: [ChatItemGroup] = []
        var currentGroup: ChatItemGroup = ChatItemGroup(chatItems: [])
        
        guard let currentUserId = currentUserId else {
            return []
        }
        
        for message in messages.sorted(by: { $0.sentAt < $1.sentAt }) {
            let isRecieved = message.userId == currentUserId
            
            if (currentGroup.chatItems.isEmpty) {
                currentGroup.isRecieved = isRecieved
                currentGroup.chatItems.append(ChatItem(message: message, isRecieved: isRecieved))
            } else {
                if (currentGroup.chatItems.allSatisfy({ chatItem in
                    chatItem.message.userId == message.userId
                })) {
                    
                    if var lastItem = currentGroup.chatItems.last {
                        let calendar = Calendar.current
                        let interval = calendar.dateComponents([.minute], from: lastItem.message.sentAt, to: message.sentAt)
                        if let areLongEnoughApart = interval.minute  {
                            if (areLongEnoughApart >= 30) {
                                chatItemGroups.append(currentGroup)
                                currentGroup = ChatItemGroup(chatItems: [])
                                currentGroup.chatItems.append(ChatItem(message: message, isRecieved: isRecieved))
                            } else {
                                lastItem.isLast = false
                                currentGroup.chatItems[currentGroup.chatItems.count - 1] = lastItem
                                
                                currentGroup.chatItems.append(ChatItem(message: message, isRecieved: isRecieved, isFirst: false))
                            }
                        }
                    }
                                        
                } else {
                    chatItemGroups.append(currentGroup)
                    currentGroup = ChatItemGroup(chatItems: [])
                    currentGroup.chatItems.append(ChatItem(message: message, isRecieved: isRecieved))
                }
            }
        }
        
        chatItemGroups.append(currentGroup)
        
        chatItemGroups.forEach { group in
            print(group.chatItems)
            print("next")
        }

        return chatItemGroups
    }
}
