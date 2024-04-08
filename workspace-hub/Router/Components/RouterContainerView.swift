//
//  RouterContainerView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 04.04.2024.
//

import SwiftUI

struct RouterContainerView<Content: View>: View {
    
    @State private var showBack: Bool = true
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            RouterBar(showBack: showBack)
            content
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
        }
        .navigationBarHidden(true)
        .onPreferenceChange(
            RouterBarBackArrowHiddenPreferenceKey.self,
            perform: { value in
                self.showBack = !value
            }
        )
    }
}

#Preview {
    RouterContainerView {
        ZStack {
            Color.black.ignoresSafeArea()
        }
        .routerBarBackArrowHidden(false)
    }
}
