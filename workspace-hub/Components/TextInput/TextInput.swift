//
//  BaseTextInput.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 19.03.2024.
//

import SwiftUI

struct TextInput: View {
    @Binding var value: String
    var placeholder: String? = nil
    var label: String? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            if let labelText = label {
                Text(labelText)
                .foregroundStyle(.secondary900)
                .font(
                    .baseFont(
                        font: .inter,
                        style: .regular,
                        size: .label
                    )
                )
            }
            // MARK: This could by achieved by many ways, but this leaves us room for leading and trailing icons
            HStack(alignment: .top) {
                TextField(
                    placeholder ?? "Enter text",
                    text: $value
                )
                .foregroundStyle(.grey700)
                .font(
                    .baseFont(
                        font: .inter,
                        style: .regular,
                        size: .base
                    )
                )
            }
            .padding(16)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                .stroke(.grey300, lineWidth: 1)
            )
        }
    }
}

#Preview {
    TextInput(
        value: .constant(""),
        placeholder: "Enter text",
        label: "Label"
    )
}
