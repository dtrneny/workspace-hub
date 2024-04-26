//
//  WorkspaceDetailView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 26.04.2024.
//

import SwiftUI

struct WorkspaceDetailView: View {
    
    var workspaceId: String
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .foregroundStyle(.secondary900)
            Text(workspaceId)
                .foregroundStyle(.secondary900)
        }
    }
}
