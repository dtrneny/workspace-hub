//
//  WorkspaceRow.swift
//  workspace-hub
//
//  Created by František on 11.04.2024.
//

import SwiftUI

struct WorkspaceListRow: View {
    
    var title: String
    var symbol: String
    var backgroundHexString: String?
    var action: (() -> Void)?
    
    var circleColor: Color {
        if let hexValue = backgroundHexString {
            return Color(uiColor: HexColorsUtil.getUIColorByHexString(hexString: hexValue))
        }
        
        return Color.primaryRed700
    }
        
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .foregroundColor(circleColor)
                    .frame(width: 50, height: 50)
                    .overlay(
                        Image(systemName: symbol)
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
                }
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
