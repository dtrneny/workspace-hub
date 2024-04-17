//
//  SquareButton.swift
//  workspace-hub
//
//  Created by František on 11.04.2024.
//

import SwiftUI

struct OperationButton: View {
    
    var icon: String
    var color: Color = .secondary900
    var rounded: Bool? = false
    var action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                if(rounded == true){
                    Circle()
                        .foregroundColor(color.opacity(0.05))
                        .frame(width: 35, height: 35)
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(color.opacity(0.05))
                        .frame(width: 35, height: 35)
                }
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.system(size: 20))
            }
        }
        .frame(width: 30, height: 30, alignment: .center)
    }
}

#Preview {
    OperationButton(icon: "chevron.right", color: .primaryRed700) {
        print("Button click")
    }
}
