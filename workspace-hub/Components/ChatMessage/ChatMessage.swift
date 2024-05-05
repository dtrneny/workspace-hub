//
//  ChatMessage.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 03.05.2024.
//

import SwiftUI

struct ChatMessage: View {
    
    var chatItem: ChatItem
    
    var recievedAlignment: HorizontalAlignment {
        return chatItem.isRecieved
            ? .trailing
            : .leading
    }
    
    var messageInfo: String {
        return chatItem.isRecieved
        ? "\(ChatUtil.formatDateString(value: chatItem.message.sentAt)) | \(chatItem.message.fullname)"
            : "\(chatItem.message.fullname) | \(ChatUtil.formatDateString(value: chatItem.message.sentAt))"
    }
    
    var body: some View {
        if (chatItem.isRecieved) {
            messageFromCurrent
        } else {
            messageFromOther
        }
    }
}

extension ChatMessage {
    
    private var messageFromCurrent: some View {
        HStack(alignment: .bottom, spacing: 10) {
            Spacer()
            
            VStack (alignment: recievedAlignment, spacing: 5) {
                
                if (chatItem.isFirst) {
                    fullname
                }
                
                messageText
                
            }
            .if(!chatItem.isLast) { view in
                view.padding([.trailing], 54)
            }
                    
            if (chatItem.isLast) {
                userAvatar
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private var messageFromOther: some View {
        HStack(alignment: .bottom, spacing: 10) {
            if (chatItem.isLast) {
                userAvatar
            }
            
            VStack (alignment: recievedAlignment, spacing: 5) {
                if (chatItem.isFirst) {
                    fullname
                }
                
                messageText

            }
            .if(!chatItem.isLast) { view in
                view.padding([.leading], 54)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

    
    private var fullname: some View {
        Text(messageInfo)
            .foregroundStyle(.secondary900)
            .font(.inter(12.0))
    }
    
    private var messageText: some View {
        Text(chatItem.message.text)
            .foregroundStyle(chatItem.isRecieved
                 ? .white
                 : .secondary900
            )
            .font(.inter(16.0))
            .padding(12)
            .frame(minHeight: 45, alignment: .leading)
            .background(chatItem.isRecieved
                ? .secondary900
                : .grey300
            )
            .cornerRadius(10)
            .if(chatItem.isRecieved) { view in
                view.padding([.leading], 35)
            }
            .if(!chatItem.isRecieved) { view in
                view.padding([.trailing], 35)
            }

    }
    
    private var userAvatar: some View {
        VStack {
            if let cachedImage = ImageCache.shared.getImage(urlString: chatItem.message.userPhotoUrlString) {
                Image(uiImage: cachedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
            } else {
                Circle()
                    .foregroundColor(.secondary900)
                    .frame(width: 45, height: 45)
                    .overlay(
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                    )
            }
        }
    }
    
}

#Preview {
    VStack (spacing: 10) {
        ChatMessage(chatItem:
            ChatItem(
                message: Message(
                    id: "1",
                    userId: "1",
                    text: "How are you doin?",
                    sentAt: Date(),
                    groupId: "1",
                    userPhotoUrlString: "https://cataas.com/cat",
                    fullname: "John Doe"
                ),
                isRecieved: true
            )
        )
        ChatMessage(chatItem:
            ChatItem(
                message: Message(
                    id: "1",
                    userId: "1",
                    text: "Fine buddy. What about you? How are you doin?",
                    sentAt: Date(),
                    groupId: "1",
                    userPhotoUrlString: "https://cataas.com/cat",
                    fullname: "Emily Doe"
                ),
                isRecieved: false
            )
        )
    }
}
