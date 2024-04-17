//
//  RouterProtocol.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import Foundation
import SwiftUI

protocol RouterProtocol: ObservableObject {
    associatedtype Routes: Hashable
    
    var history: NavigationPath { get set }
    var currentRoute: Routes? { get set }
    
    func navigate(to route: Routes)
    func pop()
    func replaceAll(with route: Routes)
}
