//
//  SignUpView.swift
//  workspace-hub
//
//  Created by František on 21.03.2024.
//

import SwiftUI
import PhotosUI

struct SignUpView: View {
    
    @EnvironmentObject var mainRouter: MainRouter
    @StateObject private var viewModel = SignUpViewModel(accountService: AccountService())
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Sign up")
                .foregroundColor(.secondary900)
                .font(.inter(30.0))
                .fontWeight(.bold)
                .padding([.bottom], 38)
            
            profilePicture
            
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
    
    private var profilePicture: some View {
        VStack (alignment: .center) {
            picturePlaceholder
        }
        .frame(maxWidth: .infinity)
    }
    
    private var picturePlaceholder: some View {
        PhotosPicker(selection: $viewModel.photo, matching: .images, photoLibrary: .shared()) {
            if let image = viewModel.loadedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 125, height: 125)
                    .clipShape(Circle())
            } else {
                ZStack {
                    Circle()
                        .fill(.grey300)
                        .frame(width: 125, height: 125)
                    
                    Image(systemName: "camera")
                        .font(.system(size: 24))
                }
            }
        }
        .onChange(of: viewModel.photo, viewModel.loadImage)
        .padding([.bottom], 19)
    }
}
