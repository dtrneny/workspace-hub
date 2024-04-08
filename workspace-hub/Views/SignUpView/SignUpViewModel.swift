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
    let accountService: AccountServiceProtocol

    @Published var fullname: FieldValue<String> = FieldValue("", rules: [
        AnyValidationRule(NonEmptyRule())
    ])
    @Published var email: FieldValue<String> = FieldValue("", rules: [
        AnyValidationRule(NonEmptyRule())
    ])
    @Published var password: FieldValue<String> = FieldValue("", rules: [
        AnyValidationRule(NonEmptyRule())
    ])
    @Published var confPassword: FieldValue<String> = FieldValue("", rules: [
        AnyValidationRule(NonEmptyRule())
    ])
    
    init(accountService: AccountServiceProtocol) {
        self.accountService = accountService
    }
    
    var passwordsMatch: Bool {
        return (!password.value.isEmpty && !confPassword.value.isEmpty) && (password.value == confPassword.value)

    }
    
    func signUp() async {
        do {
            let user = try await AuthService.shared.signUp(email: email.value, password: password.value).get()
            let _ = await accountService.createAccount(account: Account(email: email.value, fullname: fullname.value), id: user.uid)
        }
        catch {
            print(error)
        }
    }
}
