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
    
    func signUp() async {
        let result = await AuthService.shared.signUp(email: email, password: password, fullname: name)
        print(result)
    }
}
