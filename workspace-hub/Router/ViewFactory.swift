//
//  ViewFactory.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 04.04.2024.
//

import Foundation
import SwiftUI

enum ViewFactory {
    
    @ViewBuilder
    static func viewForDestination(_ path: RouterPaths) -> some View {
        switch path {
        case .signIn:
            RouterContainerView {
                SignInView()
                    .routerBarBackArrowHidden(true)
            }
        case .signUp:
            RouterContainerView {
                SignUpView()
                    .routerBarBackArrowHidden(false)
            }
        case .workspaces:
            RootTabView()
        }
    }
}
