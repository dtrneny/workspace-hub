//
//  FilledButtonStyle.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 22.03.2024.
//

import Foundation
import SwiftUI

struct FilledButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .padding()
            .background(.secondary900)
            .cornerRadius(10)
            .font(.inter(16.0))
            .fontWeight(.semibold)
    }
}

extension Button {
    func filledButtonStyle() -> some View {
        buttonStyle(FilledButtonStyle())
    }
}
