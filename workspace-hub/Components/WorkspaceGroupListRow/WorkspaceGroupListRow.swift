//
//  WorkspaceGroupListRow.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 02.05.2024.
//

import SwiftUI

struct WorkspaceGroupListRow: View {
    
    var title: String
    var symbol: String
    var action: (() -> Void)?
    
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .foregroundColor(.grey300)
                    .frame(width: 50, height: 50)
                    .overlay(
                        Image(systemName: symbol)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.secondary900)
                            .frame(width: 30, height: 30)
                    )
                            
                Text(title)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 85)
        .background(.secondary900)
        .cornerRadius(20)
        .padding([.bottom], 5)
        .onTapGesture {
            action?()
        }
    }
}
