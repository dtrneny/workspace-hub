//
//  FormField.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 20.04.2024.
//

import SwiftUI

struct FormField<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            content
            Spacer()
        }
    }
}
