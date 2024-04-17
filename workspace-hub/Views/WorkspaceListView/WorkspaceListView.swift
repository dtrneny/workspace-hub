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
            switch selectedOption {
            case 0:
                Text("Option 1 selected")
            case 1:
                Text("Option 2 selected")
            case 2:
                Text("Option 3 selected")
            default:
                Text("Unknown option")
            }
            
            Button("Change") {
                coordinator.changeSection(to: .detail)
            }
            
            // Picker to select the option
            Picker("Options", selection: $selectedOption) {
                Text("Option 1").tag(0)
                Text("Option 2").tag(1)
                Text("Option 3").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
        }
    }
}

#Preview {
    WorkspaceListView()
}
