//
//  OnboardingView.swift
//  workspace-hub
//
//  Created by František on 21.03.2024.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        NavigationView(content: {
            VStack{
                Spacer()
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .padding(.bottom, 30)
                Text("Workspace Hub")
                    .font(.system(size: 32))
                    .bold()
                    .padding(.bottom, 5)
                Text("Now your workspaces are in one place and always under control")
                    .font(.system(size: 17))
                    .foregroundColor(.grey700)
                    .multilineTextAlignment(.center)
                Spacer()
                NavigationLink(destination: SignInView()) {
                    Text("Sign in")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.secondary900)
                        .cornerRadius(10)
                }
                .padding(.bottom, 5)
                NavigationLink(destination: SignUpView()) {
                    Text("Create an account")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.secondary900)
                        .cornerRadius(10)
                }
                .padding(.bottom, 5)
                NavigationLink(destination: Text("Destination")) {
                    Text("Continue as guest")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.black)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                        )
                }
                .padding(.bottom, 5)
                Spacer()
            }
            .padding([.leading, .trailing], 20)
//            .navigationBarBackButtonHidden()
        })
    }
}

#Preview {
    OnboardingView()
}
