//
//  SignInView.swift
//  workspace-hub
//
//  Created by František on 21.03.2024.
//

import SwiftUI

struct SignInView: View {
    
    @StateObject private var viewModel = SignInViewModel()
    @EnvironmentObject var router: Router
    
    var body: some View {
        BaseLayout(content: {
            ViewTitle(title: "Hi, Welcome!")
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
            
            Button(action: {
                viewModel.signInUser()
                router.navigate(to: .fruitList)
            }, label: {
                Text("Sign in")
            })
            .filledButtonStyle()
            
            Spacer()
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
                            router.navigate(to: .signUp)
                        }
                }
            }
            Spacer()
        }, router: router)
        
//                    Button(action: {
//                        viewModel.rememberMe.toggle()
//                    }) {
//                        ZStack {
//                           Circle()
//                                .stroke(Color.grey300, lineWidth: 1)
//                                .frame(width: 20, height: 20)
//                           
//                            if viewModel.rememberMe {
//                               Circle()
//                                    .fill(Color.secondary900)
//                                    .frame(width: 20, height: 20)
//                               
//                               Image(systemName: "checkmark")
//                                   .resizable()
//                                   .aspectRatio(contentMode: .fit)
//                                   .foregroundColor(.white)
//                                   .frame(width: 12, height: 12)
//                           }
//                       }
//                    }

    }
}

#Preview {
    SignInView()
}
