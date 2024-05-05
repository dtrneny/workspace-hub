//
//  EmptyChatPlaceholder.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 05.05.2024.
//

import SwiftUI

struct EmptyChatPlaceholder: View {
    var body: some View {
        VStack {
            Image("no_messages")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 200, maxHeight: 200)
                .padding([.bottom], 38)
            
            
            VStack (alignment: .center, spacing: 5) {
                Text("No chat messages found")
                    .foregroundStyle(.secondary900)
                    .font(.inter(18.0))
                    .fontWeight(.medium)
                
                Text("You can start the conversation")
                    .foregroundStyle(.secondary900)
                    .font(.inter(14.0))
                    .fontWeight(.regular)
            }
        }
        .padding([.bottom], 38)
    }
}

#Preview {
    EmptyChatPlaceholder()
}
