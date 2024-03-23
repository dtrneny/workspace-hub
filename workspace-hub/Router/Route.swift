//
//  Routes.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 22.03.2024.
//

import Foundation

public enum Route: Codable, Hashable {
    case onBoarding
//    case bedroom(owner: String)
    case signIn
    case signUp
    case fruitList
}
