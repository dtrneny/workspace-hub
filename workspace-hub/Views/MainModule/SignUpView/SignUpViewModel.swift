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
    @Published var singingUp: Bool = false

    let accountService: AccountServiceProtocol

    @Validated(rules: [nonEmptyRule])
    var fullname: String = ""
    @Published var fullnameError: String? = nil
    
    @Validated(rules: [nonEmptyRule])
    var email: String = ""
    @Published var emailError: String? = nil
    
    @Validated(rules: [nonEmptyRule])
    var password: String = ""
    @Published var passwordError: String? = nil
    
    @Validated(rules: [nonEmptyRule])
    var confPassword: String = ""
    @Published var confPasswordError: String? = nil
    
    @Published var photo: PhotosPickerItem? = nil
    @Published var loadedImage: UIImage? = nil
    
    init(accountService: AccountServiceProtocol) {
        self.accountService = accountService
    }
    
    var passwordsMatch: Bool {
        return  password == confPassword
    }
    
    func signUp() async -> Bool {
        if (!$fullname.isValid() || !$email.isValid() || !$password.isValid() || !$confPassword.isValid()) {
            fullnameError = $fullname.getError()
            emailError = $email.getError()
            passwordError = $password.getError()
            confPasswordError = $confPassword.getError()
                        
            return false
        }
        
        if (password != confPassword) {
            confPasswordError = "Passwords are not matching."
            return false
        }
        
        do {
            singingUp = true
            let user = try await AuthService.shared.signUp(email: email, password: password).get()
            
            guard let photoData = try await photo?.loadTransferable(type: Data.self) else { return false }
            guard let (path, _) = try await StorageService.shared.saveImage(
                data: photoData,
                folder: StorageFolder.profilePictures,
                path: user.uid
            ).get() else { return false }
                
            let url = try await StorageService.shared.getUrlForImage(path: path).get()
            
            let _ = await accountService.createAccount(
                account: Account(email: email, fullname: fullname, profileImage: url.absoluteString),
                id: user.uid
            )
            
            singingUp = false
            return true
        }
        catch {
            print(error)
            return false
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
