//
//  BackArrow.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 22.03.2024.
//

import SwiftUI

struct BackArrow: View {
    var action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "chevron.left")
            .foregroundColor(.secondary900)
            .font(.system(size: 20))
        }
        .frame(width: 40, height: 40, alignment: .center)
        .background(
            RoundedRectangle(
                cornerRadius: 8,
                style: .continuous
            )
            .stroke(.grey300, lineWidth: 1)
        )
    }
}

#Preview {
    BackArrow {
        print("Back arrow click")
    }
}
