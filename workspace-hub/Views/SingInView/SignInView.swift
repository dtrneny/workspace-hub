//
//  SignInView.swift
//  workspace-hub
//
//  Created by František on 21.03.2024.
//

import SwiftUI

struct SignInView: View {
    
    @EnvironmentObject var router: Router
    @StateObject private var viewModel = SignInViewModel()
    
    var body: some View {
        BaseLayout {
            ViewTitle(title: "Hi, Welcome!")
            
            formView
            
            Button("Sign in") {
                Task {
                    let success = await viewModel.signIn()
                    if (success) {
                        router.navigate(route: .dashboard)
                    }
                }
            }.filledButtonStyle()
            
            Spacer()
            
            dividerSignUpView
            
            Spacer()
        }
    }
}

//#Preview {
//    VStack {
//        NavBar(showBack: false)
//        SignInView()
//    }
//}

extension SignInView {
    
    private var formView: some View {
        VStack(spacing: 19) {
            TextInput(
                value: $viewModel.email,
                placeholder: "Enter your e-mail",
                label: "E-mail address"
            )
            ProtectedInput(
                value: $viewModel.password,
                placeholder: "Enter your password",
                label: "Password"
            )
        }
        .padding(.bottom, 38)
    }
    
    private var dividerSignUpView: some View {
        VStack {
            HStack (alignment: .center, spacing: 20) {
                VStack {
                    Divider()
                       .background(Color.grey300)
                }

                Text("Or with")
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
                        router.navigate(route: .signUp)
                    }
            }
        }
    }
}
