//
//  ViewState.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.03.2024.
//

import Foundation

enum ViewState {
    case idle
    case loading
    case success
    case error(message: String)
}
