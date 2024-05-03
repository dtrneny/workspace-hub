//
//  ViewTitle.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 22.03.2024.
//

import SwiftUI

struct ViewTitle: View {
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
    ViewTitle(title: "View title")
}
