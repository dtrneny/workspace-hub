//
//  BaseLayout.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 22.03.2024.
//

import SwiftUI

struct BaseLayout<Content: View>: View {
    @ViewBuilder let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            content
                .padding([.leading, .trailing])
            
            Spacer()
        }
        .background(.white)
    }
}
