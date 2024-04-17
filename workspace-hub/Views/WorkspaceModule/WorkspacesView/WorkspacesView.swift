//
//  WrokspacesView.swift
//  workspace-hub
//
//  Created by František on 11.04.2024.
//

import SwiftUI

struct WorkspacesView: View {
    
    @StateObject private var viewModel = RootTabViewModel()
    
    var body: some View {
        VStack {
            TabView {
                ZStack {
                    Color.white
                        .ignoresSafeArea()
                    
                    VStack {
                        HStack {
                            ViewTitle(title: "Newest activity")
                            Spacer()
                            SquareButton(action: {}, systemName: "chevron.right")
                                .padding(.trailing, 5)
                        }
                        ActivityRow(title: "Naomi Foo", text: "Hey there! Just wanted to touch base and say thanks for all your hard  work on editing the video. Really appreciate your dedication to making  it...", systemName: "heart.fill", action: {}, imageColor: .cyan)
                            .padding(.bottom, 30)
                        
                        HStack {
                            ViewTitle(title: "Workspaces")
                            Spacer()
                            SquareButton(action: {}, systemName: "plus")
                                .padding(.trailing, 5)
                        }
                        
                        ScrollView {
                            WorkspaceRow(title: "Video editing", text: "New notifications: 5", systemName: "camera.fill", action: {}, imageColor: .purple)
                            
                            WorkspaceRow(title: "Web design", text: "No new notifications", systemName: "paintbrush.fill", action: {}, imageColor: .yellow)
                            
                            WorkspaceRow(title: "Video editing", text: "New notifications: 5", systemName: "camera.fill", action: {}, imageColor: .green)
                            
                            WorkspaceRow(title: "Video editing", text: "New notifications: 5", systemName: "camera.fill", action: {}, imageColor: .red)
                            
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    WorkspacesView()
}
