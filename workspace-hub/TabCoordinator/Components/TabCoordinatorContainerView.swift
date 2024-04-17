//
//  TabCoordinatorContainerView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import SwiftUI

struct TabCoordinatorContainerView<Content: View>: View {
    
    @State private var showBack: Bool = true
    
    let content: Content
    let coordingator: any TabCoordinatorProtocol
    
    init(@ViewBuilder content: () -> Content, coordingator: any TabCoordinatorProtocol) {
        self.content = content()
        self.coordingator = coordingator
    }
    
    var body: some View {
        VStack(spacing: 0) {
            BaseNavigationBar(showBack: showBack && coordingator.history.count > 1) {
                coordingator.pop()
            }
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
