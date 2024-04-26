//
//  MainRouter.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import Foundation
import SwiftUI

enum MainRoutes: Hashable {
    case signIn
    case signUp
    case home
    case workspaceAddition
}

class MainRouter: BaseRouter<MainRoutes> {}
