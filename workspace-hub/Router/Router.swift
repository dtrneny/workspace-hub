//
//  Router.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 03.04.2024.
//

import Foundation
import SwiftUI

class Router: ObservableObject {
    
    @Published var history: NavigationPath = NavigationPath()
    
    func navigate(route: RouterPaths)  {
        history.append(route)
    }
    
    func pop()  {
        if (!history.isEmpty) {
            history.removeLast()
        }
    }
}
