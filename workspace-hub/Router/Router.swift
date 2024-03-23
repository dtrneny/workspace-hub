//
//  Router.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 22.03.2024.
//

import Foundation
import SwiftUI

final class Router: ObservableObject {
    @Published var navPath = NavigationPath()
    
    func navigate(to route: Route) {
        navPath.append(route)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
