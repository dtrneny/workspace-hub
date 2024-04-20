//
//  SettingListViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import Foundation
import SwiftUI

@MainActor
class SettingListViewModel: ViewModelProtocol {
    @Published var state: ViewState = .idle
    
    @Validated(rules: [nonEmptyRule])
    var username: String = ""
    @Published var usernameError: String? = nil
    
    func submitForm() {
        if (!$username.isValid()) {
            usernameError = $username.getError()
            return
        }
        
        print(username)
    }

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
