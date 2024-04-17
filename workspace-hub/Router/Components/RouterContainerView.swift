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
    let router: any RouterProtocol
    
    init(@ViewBuilder content: () -> Content, router: any RouterProtocol) {
        self.content = content()
        self.router = router
    }
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                BaseNavigationBar(showBack: showBack && router.history.count > 1) {
                    router.pop()
                }
                content
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity
                    )
                    .padding([.leading, .trailing])
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .onPreferenceChange(
            RouterBarBackArrowHiddenPreferenceKey.self,
            perform: { value in
                self.showBack = !value
            }
        )
    }
}
