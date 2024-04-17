//
//  SettingListViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import Foundation

import Foundation
import SwiftUI

@MainActor
class SettingListViewModel: ViewModelProtocol {
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
