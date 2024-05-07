//
//  ChatLayout.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 02.05.2024.
//

import SwiftUI

struct ChatSubmit {
    var text: String
    var sentAt: Date
}

struct ChatLayout<Content: View>: View {
    
    let content: Content
    let submitMessage: (_ message: ChatSubmit) -> Void
    
    @FocusState private var isFocused: Bool
    @State var text: String = ""
    
    init(@ViewBuilder content: () -> Content, submitMessage: @escaping (_ message: ChatSubmit) -> Void) {
        self.content = content()
        self.submitMessage = submitMessage
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onTapGesture {
                    isFocused = false
                }
            
            Spacer()

            controls
        }
    }
}

extension ChatLayout {
    
    private var controls: some View {
        HStack(spacing: 20) {
            TextField(
                "",
                text: $text,
                prompt: Text("Enter message").foregroundStyle(.grey300),
                axis: .vertical
            )
            .focused($isFocused)
            .tint(.black)
            .foregroundStyle(.grey700)
            .font(.inter(16.0))
            .padding(16)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.grey300, lineWidth: 1)
            )
            .onTapGesture { isFocused = true }
            .lineLimit(5)
            
            HStack(spacing: 14) {
//                OperationButton(icon: "paperclip") {
//                    print("clipped")
//                }
                
                OperationButton(icon: "paperplane.fill") {
                    submitMessage(
                        ChatSubmit(
                            text: text,
                            sentAt: Date()
                        )
                    )
                    isFocused = false
                    text = ""
                }
            }
        }
        .padding([.top])
    }
    
}

