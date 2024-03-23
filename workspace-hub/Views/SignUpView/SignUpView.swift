//
//  SignUpView.swift
//  workspace-hub
//
//  Created by František on 21.03.2024.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel = SignUpViewModel()
    @EnvironmentObject var router: Router
    
    var body: some View {
        BaseLayout(content: {
            ViewTitle(title: "Sign up")
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
            
            Button(action: {
                viewModel.registerUser()
                router.navigate(to: .signIn)
            }, label: {
                Text("Create account")
            })
            .filledButtonStyle()
        }, router: router)
    }
}

#Preview {
    SignUpView()
}
