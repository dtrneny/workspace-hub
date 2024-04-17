//
//  NewestAcitvityCard.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import SwiftUI

struct WorkspaceAcitvityCard: View {
    
    var title: String
    var text: String
    var image: String
    var action: () -> Void
    
    var body: some View {
        ZStack {
            HStack(alignment: .top, spacing: 19) {
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .foregroundColor(.white)
                        .font(.inter(18.0))
                        .fontWeight(.semibold)
                    Text(text)
                        .foregroundColor(.grey300)
                        .font(.inter(16.0))
                        .fontWeight(.regular)
                        .padding([.trailing], 8)
                }
            }
            .padding(25)
            .zIndex(1)
            
            decorativeCircles
        }
        .frame(maxWidth: .infinity, maxHeight: 150, alignment: .leading)
        .clipped()
        .background(.secondary900)
        .cornerRadius(20)
        .onTapGesture {
            action()
        }
    }
}

extension WorkspaceAcitvityCard {
    private var decorativeCircles: some View {
        ZStack {
            Circle()
                .fill(.primaryViolet700)
                .frame(width: 150, height: 150)
                .offset(x: -180, y: 100)
            
            Circle()
                .fill(.clear)
                .stroke(.primaryViolet700, lineWidth: 25)
                .frame(width: 150, height: 150)
                .offset(x: 180, y: -100)
        }
    }
}

#Preview {
    VStack {
        WorkspaceAcitvityCard(
            title: "Naomi Foo",
            text: "Hey there! Just wanted to touch base and say thanks for all your hard  work on editing the video. Really appreciate your dedication to making  it...",
            image: "logo"
        ) {
            print("clicked")
        }
    }
    .padding()
}
