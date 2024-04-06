//
//  SignUpView.swift
//  workspace-hub
//
//  Created by František on 21.03.2024.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var router: Router
    @StateObject private var viewModel = SignUpViewModel()
    
    var body: some View {
        BaseLayout{
            ViewTitle(title: "Sign up")
            
            formView
            
            Button("Create account") {
                Task {
                    await viewModel.signUp()
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
                value: $viewModel.name,
                placeholder: "e. g. John Doe",
                label: "Fullname"
            )
            TextInput(
                value: $viewModel.email,
                placeholder: "e. g. example@workspacehub.com",
                label: "E-mail address"
            )
            ProtectedInput(
                value: $viewModel.password,
                placeholder: "Enter your password",
                label: "Password"
            )
            ProtectedInput(
                value: $viewModel.passwordConfirmation,
                placeholder: "Enter your password",
                label: "Confirm password"
            )
        }
        .padding(.bottom, 38)
    }
}
