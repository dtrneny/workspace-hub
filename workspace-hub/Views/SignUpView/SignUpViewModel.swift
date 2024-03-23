//
//  SignUpViewModel.swift
//  workspace-hub
//
//  Created by František on 21.03.2024.
//

import Foundation
import SwiftUI

class SignUpViewModel: ViewModelProtocol {
    @Published var state: ViewState = .idle
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordConfirmation: String = ""
    
    func registerUser() {
        AuthService.shared.createRootUser(email: email, password: password) { (user, error) in
            if let error = error {
                print("Error posting fruits: \(error.localizedDescription)")
            } else {
                print(user ?? "nah")
            }
        }
    }
}
