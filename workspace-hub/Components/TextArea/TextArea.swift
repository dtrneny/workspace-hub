//
//  TextArea.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 06.05.2024.
//

import SwiftUI

struct TextArea: View {
    
    @Binding var value: String
    @FocusState private var isFocused: Bool
    
    var label: LocalizedStringResource? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            
            VStack(alignment: .leading) {
                if let labelText = label {
                    Text(labelText)
                        .foregroundStyle(.secondary900)
                        .font(.inter(16.0))
                }
                
                TextEditor(text: $value)
                    .focused($isFocused)
                    .tint(.black)
                    .foregroundStyle(.grey700)
                    .font(.inter(16.0))
                    .padding(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.grey300, lineWidth: 1)
                    )
                    .frame(minHeight: 150, maxHeight: 250)
                    .fixedSize(horizontal: false, vertical: true)
                    .onTapGesture { isFocused = true }
            }
        }
    }
}
