//
//  FruitListViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 15.03.2024.
//

import Foundation
import SwiftUI

@MainActor
class RootTabViewModel: ViewModelProtocol {
    @Published var state: ViewState = .idle

    func signOut() -> Bool {
        do {
            let result = try AuthService.shared.signOut().get()
            return result
        }
        catch {
            return false
        }
    }
}
