//
//  SettingAccountEditView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 27.04.2024.
//

import SwiftUI
import PhotosUI

struct SettingAccountEditView: View {
    
    @EnvironmentObject var coordinator: SettingCoordinator

    @ObservedObject var viewModel = SettingAccountEditViewModel(
        accountService: AccountService()
    )
    
    var body: some View {
        BaseLayout {
            switch viewModel.state {
            case .loading:
                LoadingDots(type: .view)
            default:
                ViewTitle(title: "Edit account")
                
                profilePicture
                
                formView
                
                editButton
            }
        }
        .routerBarBackArrowHidden(viewModel.updatingUser)
        .onAppear {
            Task {
                await viewModel.fetchInitialData()
            }
        }
    }
}

extension SettingAccountEditView {
    
    private var formView: some View {
        VStack(spacing: 19) {
            FormField {
                TextInput(
                    value: $viewModel.firstname,
                    placeholder: "e. g. John",
                    label: "Firstname"
                )
                if let error = viewModel.firstnameError {
                    ErrorMessage(error: error)
                }
            }
            FormField {
                TextInput(
                    value: $viewModel.lastname,
                    placeholder: "e. g. Doe",
                    label: "Lastname"
                )
                if let error = viewModel.lastnameError {
                    ErrorMessage(error: error)
                }
            }
        }
        .padding(.bottom, 38)
    }
    
    private var editButton: some View {
        BaseButton {
            Task {
                if (await viewModel.updateAccount()) { coordinator.pop() }
            }
        } content: {
            HStack (spacing: 8) {
                if (viewModel.updatingUser) {
                    ProgressView()
                        .tint(.white)
                }
                Text("Edit account")
            }
        }
        .padding([.bottom], 76)
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

