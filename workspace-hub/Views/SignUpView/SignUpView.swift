//
//  SignUpView.swift
//  workspace-hub
//
//  Created by František on 21.03.2024.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel = SignUpViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Sign up")
                    .font(.system(size: 30))
                    .bold()
                    .padding(.bottom, 30)
                    .multilineTextAlignment(.leading)
                TextInput(value: $viewModel.name, placeholder: "John Wok", label: "Fullname")
                TextInput(value: $viewModel.email, placeholder: "example@gmail.com", label: "E-mail address")
                TextInput(value: $viewModel.password, placeholder: "must be atleast 8 characters", label: "Create password")
                    .padding(.bottom, 10)
                TextInput(value: $viewModel.passwordConfirmation, placeholder: "repeat password", label: "Confirm password")
                    .padding(.bottom, 10)
                Button(action: {
                    viewModel.notificationsSubscription.toggle()
                }) {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(viewModel.notificationsSubscription ? Color.secondary900 : Color.grey300)
                        .frame(width: 50, height: 28)
                        .overlay(
                            Circle()
                                .foregroundColor(.white)
                                .shadow(radius: 2, x: 0, y: 2)
                                .padding(3)
                                .offset(x: viewModel.notificationsSubscription ? 10 : -10, y: 0)
                        )
                }
                NavigationLink(destination: OnboardingView()) {
                    Text("Create account")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.secondary900)
                        .cornerRadius(10)
                }
                .padding(.bottom, 40)
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
    SignUpView()
}
