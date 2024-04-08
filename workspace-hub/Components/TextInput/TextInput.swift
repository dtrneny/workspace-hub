//
//  BaseTextInput.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 19.03.2024.
//

import SwiftUI

struct TextInput: View {
    
    @Binding var fieldValue: FieldValue<String>
    @FocusState private var isFocused: Bool
    
    var placeholder: String? = nil
    var label: String? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            
            VStack(alignment: .leading) {
                if let labelText = label {
                    Text(labelText)
                        .foregroundStyle(.secondary900)
                        .font(.inter(14.0))
                }
                
                TextField(
                    "",
                    text: $fieldValue.value,
                    prompt: Text(placeholder ?? "Enter text").foregroundStyle(.grey300)
                )
                .focused($isFocused)
                .tint(.black)
                .foregroundStyle(.grey700)
                .font(.inter(16.0))
                .padding(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.grey300, lineWidth: 1)
                )
                .onTapGesture { isFocused = true }
            }
            
            if (!fieldValue.isValid()) {
                let errors = fieldValue.brokenRules()
                
                if (errors.count > 0) {
                    ErrorMessage(error: errors[0])
                }
            }
        }
    }
}

#Preview {
    struct Preview: View {
        @State var testingValue: FieldValue<String> = FieldValue<String>("")

        var body: some View {
            TextInput(
                fieldValue: $testingValue,
                placeholder: "Enter text",
                label: "Label"
            )
        }
    }
    
    return Preview()
        .padding()
}
