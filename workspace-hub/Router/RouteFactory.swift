//
//  ViewFactory.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 04.04.2024.
//

import Foundation
import SwiftUI

enum RouteFactory {
    @ViewBuilder
    static func viewForMainRouteDestination(_ path: MainRoutes, router: MainRouter) -> some View {
        switch path {
        case .signIn:
            RouterContainerView(content: {
                SignInView()
            }, router: router)
        case .signUp:
            RouterContainerView(content: {
                SignUpView()
                    .routerBarBackArrowHidden(false)
            }, router: router)
        case .home:
            RootTabView()
                .routerBarBackArrowHidden(true)
                .toolbar(.hidden, for: .navigationBar)
        }
    }
}
