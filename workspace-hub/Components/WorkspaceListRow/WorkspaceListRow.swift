//
//  WorkspaceRow.swift
//  workspace-hub
//
//  Created by František on 11.04.2024.
//

import SwiftUI

struct WorkspaceListRow: View {
    
    var title: String
    var notificationCount: Int
    var icon: String
    var imageColor: Color
    var action: (() -> Void)?
        
    var body: some View {
        VStack {
            HStack {
                Circle()
                .foregroundColor(imageColor)
                .frame(width: 50, height: 50)
                .overlay(
                    Image(systemName: icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.secondary900)
                        .frame(width: 30, height: 30)
                )
                            
                VStack(alignment: .leading) {
                    Text(title)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    Text("New notifications: \(notificationCount)")
                        .font(.inter(14.0))
                        .foregroundColor(.grey300)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 85)
        .background(.secondary900)
        .cornerRadius(20)
        .padding([.bottom], 15)
    }
}

#Preview {
    WorkspaceListRow(title: "Video editing", notificationCount: 5, icon: "camera.fill", imageColor: .primaryRed700)
}
