//
//  SquareButton.swift
//  workspace-hub
//
//  Created by František on 11.04.2024.
//

import SwiftUI

struct SquareButton: View {
    
    var action: () -> Void
    var systemName: String
    var color: Color?
    var backgroundColor: Color?
    var isRound: Bool?

    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                if(isRound == true){
                    Circle()
                        .foregroundColor(backgroundColor ?? .grey200)
                    .frame(width: 35, height: 35)
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(backgroundColor ?? .grey200)
                        .frame(width: 35, height: 35)
                }
                Image(systemName: systemName)
                    .foregroundColor(color ?? .secondary900)
                    .font(.system(size: 20))
            }
        }
        .frame(width: 30, height: 30, alignment: .center)
    }
}

#Preview {
    SquareButton(action: {
        print("Button click")
    }, systemName: "chevron.right", backgroundColor: .grey200, isRound: false)
}
