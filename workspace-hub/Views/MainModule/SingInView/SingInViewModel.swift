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
    
    @Published var email: FieldValue<String> = FieldValue("")
    @Published var password: FieldValue<String> = FieldValue("")
        
    func signIn() async -> Bool {
        do {
            let _ = try await AuthService.shared.signIn(email: email.value, password: password.value).get()
            return true
        }
        catch {
            return false
        }
    }
}
