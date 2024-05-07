//
//  CommonGroupListRow.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 04.05.2024.
//

import SwiftUI

struct CommonGroupListRow<Content: View>: View {
    
    var name: String
    var variableText: String
    var symbol: String
    
    let content: Content
        
    init(name: String, variableText: String, symbol: String, @ViewBuilder content: () -> Content) {
        self.name = name
        self.variableText = variableText
        self.symbol = symbol
        self.content = content()
    }
    
    var body: some View {
        HStack (alignment: .center, spacing: 10) {
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
            
            VStack (alignment: .leading) {
                Text(name)
                    .foregroundColor(.white)
                    .font(.inter(16.0))
                    .fontWeight(.semibold)
                if (!variableText.isEmpty) {
                    Text(variableText)
                        .foregroundColor(.grey300)
                        .font(.inter(14.0))
                        .fontWeight(.regular)
                }
            }
            
            Spacer()
            
            content
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.secondary900)
        .cornerRadius(15)
    }
}
