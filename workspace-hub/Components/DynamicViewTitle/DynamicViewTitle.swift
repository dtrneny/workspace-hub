//
//  DynamicViewTitle.swift
//  workspace-hub
//
//  Created by František on 06.05.2024.
//

import SwiftUI

struct DynamicViewTitle: View {
    var title: String
    
    var body: some View {
        Text(title)
            .foregroundStyle(.secondary900)
            .font(.inter(24.0))
            .fontWeight(.medium)
            .padding([.bottom], 19)
    }
}

#Preview {
    DynamicViewTitle(title: "View title")
}

