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
            .foregroundColor(.secondary900)
            .font(.inter(30.0))
            .fontWeight(.bold)
            .padding([.bottom], 38)
    }
}

#Preview {
    ViewTitle(title: "View title")
}
