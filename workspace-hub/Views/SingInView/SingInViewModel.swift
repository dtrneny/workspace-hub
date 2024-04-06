//
//  SingInViewModel.swift
//  workspace-hub
//
//  Created by František on 21.03.2024.
//

import Foundation
import SwiftUI

final class SignInViewModel: ViewModelProtocol {
    @Published var state: ViewState = .idle
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var signed: Bool = false
    
    func signIn() async -> Bool {
        // MARK: save result to local storage
        do {
            let result = try await AuthService.shared.signIn(email: email, password: password).get()
            print(result)
            return true
        } catch {
            return false
        }
    }
}
