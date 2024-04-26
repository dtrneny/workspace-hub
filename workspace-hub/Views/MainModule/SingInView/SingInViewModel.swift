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
    
    @Published var singingIn: Bool = false
    
    @Validated(rules: [nonEmptyRule])
    var email: String = ""
    @Published var emailError: String? = nil
    
    @Validated(rules: [nonEmptyRule])
    var password: String = ""
    @Published var passwordError: String? = nil
        
    func signIn() async -> Bool {
        if (!$email.isValid() || !$password.isValid()) {
            emailError = $email.getError()
            passwordError = $password.getError()
                        
            return false
        }
        
        do {
            singingIn = true
            let _ = try await AuthService.shared.signIn(email: email, password: password).get()
            singingIn = false
            return true
        }
        catch {
            passwordError = "Please provide valid credentials."
            singingIn = false
            return false
        }
    }
}
