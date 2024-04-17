//
//  SignUpView.swift
//  workspace-hub
//
//  Created by František on 21.03.2024.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var mainRouter: MainRouter
    @StateObject private var viewModel = SignUpViewModel(accountService: AccountService())
    
    var body: some View {
        VStack(alignment: .leading) {
            ViewTitle(title: "Sign up")
            
            formView
            
            Button("Create account") {
                Task {
                    await viewModel.signUp()
                    mainRouter.pop()
                }
            }.filledButtonStyle()
        }
    }
}

#Preview {
    SignUpView()
}

extension SignUpView {
    
    private var formView: some View {
        VStack(spacing: 19) {
            TextInput(
                fieldValue: $viewModel.fullname,
                placeholder: "e. g. John Doe",
                label: "Fullname"
            )
            TextInput(
                fieldValue: $viewModel.email,
                placeholder: "e. g. example@workspacehub.com",
                label: "E-mail address"
            )
            ProtectedInput(
                fieldValue: $viewModel.password,
                placeholder: "Enter your password",
                label: "Password"
            )
            VStack(alignment: .leading, spacing: 8.0) {
                ProtectedInput(
                    fieldValue: $viewModel.confPassword,
                    placeholder: "Enter your password",
                    label: "Confirm password"
                )
                if((!viewModel.confPassword.value.isEmpty && !viewModel.password.value.isEmpty) && !viewModel.passwordsMatch) {
                    ErrorMessage(error: "Passwords are not matching.")
                }
            }
        }
        .padding(.bottom, 38)
    }
}
