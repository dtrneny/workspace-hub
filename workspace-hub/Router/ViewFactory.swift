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
        RouterContainerView {
            switch path {
            case .signIn:
                SignInView()
                    .routerBarBackArrowHidden(true)
            case .signUp:
                SignUpView()
            case .dashboard:
                FruitListView()
                    .routerBarBackArrowHidden(true)
            }
        }
    }
}
