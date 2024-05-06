//
//  SignInView.swift
//  workspace-hub
//
//  Created by František on 21.03.2024.
//

import SwiftUI

struct SignInView: View {
    
    @EnvironmentObject var mainRouter: MainRouter
    
    @ObservedObject private var viewModel = SignInViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hi, Welcome!")
                .foregroundColor(.secondary900)
                .font(.inter(30.0))
                .fontWeight(.bold)
                .padding([.bottom], 38)
            
            formView
            
            signInButton
                        
            dividerSignUpView
            
            Spacer()
        }
    }
}

extension SignInView {
    
    private var formView: some View {
        VStack(spacing: 19) {
            FormField {
                TextInput(
                    value: $viewModel.email,
                    placeholder: "Enter your e-mail",
                    label: "E-mail address"
                )
                if let error = viewModel.emailError {
                    ErrorMessage(error: error)
                }
            }
            FormField {
                ProtectedInput(
                    value: $viewModel.password,
                    placeholder: "Enter your password",
                    label: "Password"
                )
                if let error = viewModel.passwordError {
                    ErrorMessage(error: error)
                }
            }
        }
        .padding(.bottom, 38)
    }
    
    private var signInButton: some View {
        BaseButton {
            HStack (spacing: 8) {
                if (viewModel.singingIn) {
                    ProgressView()
                        .tint(.white)
                }
                Text("Sign in")
                    .font(.inter(16.0))
            }
        }
        .onTapGesture {
            Task {
                if (await viewModel.signIn()) { mainRouter.replaceAll(with: [.home]) }
            }
        }
        .padding([.bottom], 76)
    }
    
    private var dividerSignUpView: some View {
        VStack {
            HStack (alignment: .center, spacing: 20) {
                VStack {
                    Divider()
                       .background(Color.grey300)
                }

                Text("Or")
                   .foregroundColor(.grey700)
                   .padding()
                   .font(.inter(16.0))
                
                VStack {
                    Divider()
                       .background(Color.grey300)
                }
            }
            .padding(.bottom, 38)
            
            HStack(alignment: .center) {
                Text("Don't have an account?")
                    .foregroundColor(.grey700)
                    .font(.inter(16.0))
                
                Text("Sign up")
                    .foregroundColor(.secondary900)
                    .background(Color.white)
                    .font(.inter(16.0))
                    .fontWeight(.semibold)
                    .onTapGesture {
                        mainRouter.navigate(to: .signUp)
                    }
            }
        }
    }
}
