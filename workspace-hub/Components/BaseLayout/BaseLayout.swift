//
//  BaseLayout.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import SwiftUI

struct BaseLayout<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            content
            Spacer()
        }
    }
}

#Preview {
    BaseLayout {
        Text("Testing")
    }
}
