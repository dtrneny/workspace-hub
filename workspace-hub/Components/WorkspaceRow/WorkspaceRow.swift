//
//  WorkspaceRow.swift
//  workspace-hub
//
//  Created by František on 11.04.2024.
//

import SwiftUI

struct WorkspaceRow: View {
    
    var title: String
    var text: String
    var systemName: String
    var action: () -> Void
    var imageColor: Color?
    
//    @State private var isExpanded = false
    
    var body: some View {
        VStack{
            HStack {
                Circle()
                .foregroundColor(imageColor ?? .gray)
                .frame(width: 60, height: 60)
                .overlay(
                    Image(systemName: systemName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.secondary900)
                        .frame(width: 30, height: 30)
                )
                .padding(.horizontal, 10)
                            
                VStack(alignment: .leading) {
                    Text(title)
                        .foregroundColor(.white)
                        .bold()
                        .lineLimit(1)
                        .truncationMode(.tail)
                    Text(text)
                        .foregroundColor(.grey300)
                        .lineLimit(4)
                        .truncationMode(.tail)
                }
                Spacer()
            }
            .padding(.vertical, 20)
            .background(.secondary900)
            .cornerRadius(20)
        }
        .padding(.bottom, 15)
//        .gesture(
//            DragGesture()
//                .onChanged { value in
//                    if value.translation.width < -50 {
//                        isExpanded = true
//                    }
//                }
//                .onEnded { value in
//                    if value.translation.width > 50 {
//                        isExpanded = false
//                    }
//                }
//        )
    }
}

#Preview {
    WorkspaceRow(title: "Video editing", text: "New notifications: 5", systemName: "camera.fill", action: {})
}
