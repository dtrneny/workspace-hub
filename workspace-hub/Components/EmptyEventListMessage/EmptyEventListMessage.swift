//
//  EmptyEventListMessage.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 07.05.2024.
//

import SwiftUI

struct EmptyEventListMessage: View {
    var body: some View {
        VStack {
            Image("no_events")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 200, maxHeight: 200)
                .padding([.bottom], 38)
                .padding([.leading], 25)
            
            
            Text("No events found")
                .foregroundStyle(.secondary900)
                .font(.inter(18.0))
                .fontWeight(.medium)
        }
    }
}

#Preview {
    EmptyEventListMessage()
}
