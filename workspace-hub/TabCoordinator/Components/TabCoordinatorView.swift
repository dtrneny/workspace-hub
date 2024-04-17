//
//  TabCoordinatorView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import SwiftUI

struct TabCoordinatorView<Coordinator: TabCoordinatorProtocol, Content: View>: View {
    
    @ObservedObject var coordinator: Coordinator
    let content: Content
    
    init(@ViewBuilder content: () -> Content, coordinator: Coordinator) {
        self.content = content()
        self.coordinator = coordinator
    }
    
    var body: some View {
        VStack {
            TabCoordinatorContainerView(content: {
                content
            }, coordingator: coordinator)
        }
    }
}
