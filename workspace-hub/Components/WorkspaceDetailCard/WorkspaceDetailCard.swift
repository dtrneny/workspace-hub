//
//  WorkspaceDetailCard.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 26.04.2024.
//

import SwiftUI

struct WorkspaceDetailCard: View {
    
    let name: String
    let icon: String
    let hexColor: String?
    
    var workspaceColor: Color {
        if let hexValue = hexColor {
            return Color(uiColor: HexColorsUtil.getUIColorByHexString(hexString: hexValue))
        }
        
        return Color.primaryRed700
    }
    
    var body: some View {
        ZStack {
            HStack(alignment: .center, spacing: 14) {
                ZStack {
                    Image(systemName: icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.secondary900)
                        .zIndex(1)
                    
                    Circle()
                        .fill(workspaceColor)
                        .frame(width: 64, height: 64)
                    
                    Circle()
                        .fill(.clear)
                        .stroke(workspaceColor, lineWidth: 2)
                        .frame(width: 72, height: 72)

                }
                
                Text(name)
                    .foregroundColor(.white)
                    .font(.inter(22.0))
                    .fontWeight(.semibold)
    
            }
            .padding([.top, .bottom], 25)
            .padding([.leading], 20)
            .zIndex(1)
            
            decorativeCircles
        }
        .frame(maxWidth: .infinity, maxHeight: 100, alignment: .leading)
        .clipped()
        .background(.secondary900)
        .cornerRadius(20)
    }
}

extension WorkspaceDetailCard {
    private var decorativeCircles: some View {
        ZStack {
            Circle()
                .fill(.clear)
                .stroke(workspaceColor, lineWidth: 25)
                .frame(width: 150, height: 150)
                .offset(x: 250, y: -80)
        }
    }
}

#Preview {
    return VStack {
        WorkspaceDetailCard(name: "Web design", icon: "sparkles", hexColor: "#FEDF6B")
    }
    .padding()
}
