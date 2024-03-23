//
//  OnboardingView.swift
//  workspace-hub
//
//  Created by František on 21.03.2024.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var router: Router

    var body: some View {
            VStack {
                VStack (alignment: .center) {
                    VStack {
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150)
                            .padding(.bottom, 30)
                        
                        Text("Workspace Hub")
                            .foregroundColor(.secondary900)
                            .padding(.bottom, 5)
                            .font(.inter(30.0))
                            .fontWeight(.bold)
                        
                        Text("Now your workspaces are in one place and always under control")
                            .foregroundColor(.grey700)
                            .multilineTextAlignment(.center)
                            .font(.inter(16.0))
                    }
                    .padding(.bottom, 50)
                    
                    VStack (spacing: 10) {
                        
                        Button(action: {
                            router.navigate(to: .signIn)
                        }, label: {
                            Text("Sign in")
                        })
                        .filledButtonStyle()
                        
                        Button(action: {
                            router.navigate(to: .signUp)
                        }, label: {
                            Text("Create an account")
                        })
                        .filledButtonStyle()
                        
                        Button(action: {
                            print("Continue as guest")
                        }, label: {
                            Text("Continue as guest")
                        })
                        .borderedButtonStyle()
                        
                    }
                }
                .padding()
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
            .background(.white)    }
}

#Preview {
    OnboardingView()
}
