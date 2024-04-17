//
//  WorkspaceListView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import SwiftUI

struct WorkspaceListView: View {
    
    @State private var selectedOption: Int = 0
    @EnvironmentObject var coordinator: WorkspaceCoordinator

    var body: some View {
        VStack {
            Text("List")
        }
    }
}

#Preview {
    WorkspaceListView()
}
