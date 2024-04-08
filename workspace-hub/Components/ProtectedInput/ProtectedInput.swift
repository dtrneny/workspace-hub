//
//  ProtectedInput.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 21.03.2024.
//

import SwiftUI

struct ProtectedInput: View {
    
    @Binding var fieldValue: FieldValue<String>
    @State private var isContentHidden = true
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
                HStack(alignment: .center) {
                    if isContentHidden {
                        secureFieldView
                    } else {
                        textFieldView
                    }
                    
                    lockIcon
                }
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

extension ProtectedInput {
    
    private var textFieldView: some View {
        TextField(
            "",
            text: $fieldValue.value,
            prompt: Text(placeholder ?? "Enter text").foregroundStyle(.grey300)
        )
        .foregroundStyle(.grey700)
        .font(.inter(16.0))
        .focused($isFocused)
    }
    
    private var secureFieldView: some View {
        SecureField(
            "",
            text: $fieldValue.value,
            prompt: Text(placeholder ?? "Enter text").foregroundStyle(.grey300)
        )
        .foregroundStyle(.grey700)
        .font(.inter(16.0))
        .focused($isFocused)
    }
    
    private var lockIcon: some View {
        HStack (alignment: .center) {
            Image(systemName: isContentHidden ? "eye.slash" : "eye")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.grey800)
                .onTapGesture { isContentHidden.toggle() }
        }
        .frame(width: 24, height: 24)
    }
}


#Preview {
    struct Preview: View {
        @State var testingValue: FieldValue<String> = FieldValue<String>("")

        var body: some View {
            ProtectedInput(
                fieldValue: $testingValue,
                placeholder: "Enter text",
                label: "Label"
            )
        }
    }
    
    return Preview()
        .padding()
}
