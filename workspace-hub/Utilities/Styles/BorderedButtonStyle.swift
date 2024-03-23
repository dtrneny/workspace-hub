//
//  BorderedButtonStyle.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 22.03.2024.
//

import Foundation
import SwiftUI

struct BorderedButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .foregroundColor(.secondary900)
            .padding()
            .background(
                RoundedRectangle(
                    cornerRadius: 10,
                    style: .continuous
                )
                .stroke(.secondary900, lineWidth: 1)
            )
            .font(.inter(16.0))
            .fontWeight(.semibold)
    }
}

extension Button {
    func borderedButtonStyle() -> some View {
        buttonStyle(BorderedButtonStyle())
    }
}
