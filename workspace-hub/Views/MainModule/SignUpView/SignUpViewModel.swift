//
//  SignUpViewModel.swift
//  workspace-hub
//
//  Created by František on 21.03.2024.
//

import Foundation
import SwiftUI
import PhotosUI

class SignUpViewModel: ViewModelProtocol {
    
    @Published var state: ViewState = .idle
    let accountService: AccountServiceProtocol

    @Published var fullname: FieldValue<String> = FieldValue("", rules: [
        AnyValidationRule(NonEmptyRule())
    ])
    @Published var email: FieldValue<String> = FieldValue("", rules: [
        AnyValidationRule(NonEmptyRule())
    ])
    @Published var password: FieldValue<String> = FieldValue("", rules: [
        AnyValidationRule(NonEmptyRule())
    ])
    @Published var confPassword: FieldValue<String> = FieldValue("", rules: [
        AnyValidationRule(NonEmptyRule())
    ])
    
    @Published var photo: PhotosPickerItem? = nil
    @Published var loadedImage: UIImage? = nil
    
    init(accountService: AccountServiceProtocol) {
        self.accountService = accountService
    }
    
    var passwordsMatch: Bool {
        return  password.value == confPassword.value

    }
    
    func signUp() async {
        do {
            let user = try await AuthService.shared.signUp(email: email.value, password: password.value).get()
            
            guard let photoData = try await photo?.loadTransferable(type: Data.self) else { return }
            guard let (path, _) = try await StorageService.shared.saveImage(
                data: photoData,
                folder: StorageFolder.profilePictures,
                path: user.uid
            ).get() else { return }
                
            let url = try await StorageService.shared.getUrlForImage(path: path).get()
            
            let _ = await accountService.createAccount(
                account: Account(email: email.value, fullname: fullname.value, profileImage: url.absoluteString),
                id: user.uid
            )
        }
        catch {
            print(error)
        }
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await photo?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
            
            loadedImage = inputImage
        }
    }
}
