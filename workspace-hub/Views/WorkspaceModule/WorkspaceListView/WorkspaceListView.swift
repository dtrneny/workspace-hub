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
        BaseLayout {
            VStack(spacing: 38) {
                VStack(alignment: .leading) {
                    ViewTitle(title: "Newest message")
                    WorkspaceAcitvityCard (
                        title: "Naomi Foo",
                        text: "Hey there! Just wanted to touch base and say thanks for all your hard  work on editing the video. Really appreciate your dedication to making  it...",
                        image: "logo"
                    ) {
                        print("clicked")
                    }
                }
                
                VStack(alignment: .leading) {
                    HStack(alignment: .firstTextBaseline) {
                        ViewTitle(title: "Workspaces")
                        
                        Spacer()
                        
                        OperationButton(icon: "plus") {
                            print("Addition")
                        }
                    }
                    
                    ScrollView {
                        ForEach(1..<10) { i in
                            WorkspaceListRow(title: "Video editing", notificationCount: 5, icon: "camera.fill", imageColor: .primaryRed700)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    WorkspaceListView()
}
