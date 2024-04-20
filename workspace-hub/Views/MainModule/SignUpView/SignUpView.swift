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
                    let result = await viewModel.signUp()
                    if (result) {
                        mainRouter.pop()
                    }
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
            FormField {
                TextInput(
                    value: $viewModel.fullname,
                    placeholder: "e. g. John Doe",
                    label: "Fullname"
                )
                if let error = viewModel.fullnameError {
                    ErrorMessage(error: error)
                }
            }
            FormField {
                TextInput(
                    value: $viewModel.email,
                    placeholder: "e. g. example@workspacehub.com",
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
            FormField {
                ProtectedInput(
                    value: $viewModel.confPassword,
                    placeholder: "Enter your password",
                    label: "Confirm password"
                )
                if let error = viewModel.confPasswordError {
                    ErrorMessage(error: error)
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
