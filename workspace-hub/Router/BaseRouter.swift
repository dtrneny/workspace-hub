//
//  BaseRouter.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import Foundation
import SwiftUI

class BaseRouter<Routes: Hashable>: ObservableObject, RouterProtocol {
        
    @Published var history: NavigationPath = NavigationPath()
    @Published var currentRoute: Routes? = nil

    func navigate(to route: Routes) {
        history.append(route)
        currentRoute = route
    }
    
    func pop() {
        if(!history.isEmpty) {
            history.removeLast()
        }
    }
    
    func replaceAll(with routes: [Routes]) {
        history = .init(routes)
        currentRoute = routes.last
    }
}
