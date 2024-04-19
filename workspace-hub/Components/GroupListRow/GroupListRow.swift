//
//  GroupListRow.swift
//  workspace-hub
//
//  Created by František on 19.04.2024.
//

import SwiftUI

struct GroupListRow: View {
    
    var title: String
    var notificationCount: Int
    var action: (() -> Void)?
        
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .lineLimit(1)
                .truncationMode(.tail)
                .padding(.leading, 15)
            Text("New notifications: \(notificationCount)")
                .font(.inter(14.0))
                .foregroundColor(.grey300)
                .lineLimit(1)
                .truncationMode(.tail)
                .padding(.leading, 15)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 85)
        .background(.secondary900)
        .cornerRadius(20)
        .padding([.bottom], 15)
    }
}

#Preview {
    GroupListRow(title: "Video editing", notificationCount: 5)
}
