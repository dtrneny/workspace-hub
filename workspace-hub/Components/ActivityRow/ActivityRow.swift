//
//  TextBoxView.swift
//  workspace-hub
//
//  Created by František on 11.04.2024.
//

import SwiftUI

struct ActivityRow: View {
    
    var title: String
    var text: String
    var systemName: String
    var action: () -> Void
    var imageColor: Color?
    
    var body: some View {
        HStack {
            Spacer()
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
            .padding(.trailing, 10)
                        
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
}

#Preview {
    ActivityRow(title: "Naomi Foo", text: "Hey there! Just wanted to touch base and say thanks for all your hard  work on editing the video. Really appreciate your dedication to making  it...", systemName: "heart.fill", action: {}, imageColor: .blue)
}
