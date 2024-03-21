//
//  SignInView.swift
//  workspace-hub
//
//  Created by František on 21.03.2024.
//

import SwiftUI

struct SignInView: View {
    @StateObject private var viewModel = SignInViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Hi, Welcome!")
                    .font(.system(size: 30))
                    .bold()
                    .padding(.bottom, 30)
                    .multilineTextAlignment(.leading)
                TextInput(value: $viewModel.email, placeholder: "Your e-mail", label: "E-mail address")
                    .padding(.bottom, 10)
                TextInput(value: $viewModel.password, placeholder: "Password", label: "Password")
                    .padding(.bottom, 10)
                HStack {
                    Button(action: {
                        viewModel.rememberMe.toggle()
                    }) {
                        ZStack {
                           Circle()
                                .stroke(Color.grey300, lineWidth: 1)
                                .frame(width: 20, height: 20)
                           
                            if viewModel.rememberMe {
                               Circle()
                                    .fill(Color.secondary900)
                                    .frame(width: 20, height: 20)
                               
                               Image(systemName: "checkmark")
                                   .resizable()
                                   .aspectRatio(contentMode: .fit)
                                   .foregroundColor(.white)
                                   .frame(width: 12, height: 12)
                           }
                       }
                    }
                    .buttonStyle(PlainButtonStyle())
                    Text("Remember me")
                        .font(.system(size: 14))
                    Spacer()
                    Text("Forgot password?")
                        .font(.system(size: 14))
                }
                    .padding(.bottom, 25)
                NavigationLink(destination: OnboardingView()) {
                    Text("Sign in")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.secondary900)
                        .cornerRadius(10)
                }
                .padding(.bottom, 40)
                ZStack(alignment: .center) {
                    Divider()
                        .background(Color.grey300)
                    
                    Text("Or with")
                        .foregroundColor(.grey700)
                        .padding()
                        .background(Color.white)
                        .font(.system(size: 14))
                }
                HStack {
                    Spacer()
                    Text("Don't have an account?")
                        .foregroundColor(.grey700)
                        .background(Color.white)
                        .font(.system(size: 14))
                    Text("Sign up")
                        .foregroundColor(.secondary900)
                        .background(Color.white)
                        .font(.system(size: 14))
                    Spacer()
                }
            }
            .padding([.top, .bottom], 10)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                }
            }
        }
        .padding([.leading, .trailing], 20)
    }
}

#Preview {
    SignInView()
}
