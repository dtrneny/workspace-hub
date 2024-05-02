//
//  EmptyListMessage.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 02.05.2024.
//

import SwiftUI

struct EmptyListMessage: View {
    
    var message: String? = nil
    
    var body: some View {
        HStack {
            Spacer()
            
            Text(message ?? "No results found")
                .font(.inter(14.0))
                .foregroundStyle(.grey700)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    EmptyListMessage()
}
