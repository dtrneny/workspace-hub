//
//  SignUpViewModel.swift
//  workspace-hub
//
//  Created by František on 21.03.2024.
//

import Foundation
import SwiftUI
import PhotosUI

final class SignUpViewModel: ViewModelProtocol {
    
    @Published var state: ViewState = .idle
    
    let accountService: AccountServiceProtocol
    
    init(accountService: AccountServiceProtocol) {
        self.accountService = accountService
    }
    
    @Published var singingUp: Bool = false

    @Validated(rules: [nonEmptyRule])
    var firstname: String = ""
    @Published var firstnameError: String? = nil
    
    @Validated(rules: [nonEmptyRule])
    var lastname: String = ""
    @Published var lastnameError: String? = nil
    
    @Validated(rules: [nonEmptyRule, emailRule])
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
    @Published var imageError: String? = nil
    
    var passwordsMatch: Bool {
        return  password == confPassword
    }
    
    func signUp() async -> Bool {
        confPasswordError = nil
        imageError = nil
        
        if (!$firstname.isValid() || !$email.isValid() || !$password.isValid() || !$confPassword.isValid() || !$lastname.isValid()) {
            firstnameError = $firstname.getError()
            lastnameError = $lastname.getError()
            emailError = $email.getError()
            passwordError = $password.getError()
            confPasswordError = $confPassword.getError()
                        
            return false
        }
        
        if (photo == nil) {
            imageError = NSLocalizedString("Please choose your profile image.", comment: "")
            return false
        }
        
        if (password != confPassword) {
            confPasswordError = NSLocalizedString("Passwords are not matching.", comment: "")
            return false
        }
        
        do {
            singingUp = true
            let user = try await AuthService.shared.signUp(email: email, password: password).get()
            
            guard let photoData = try await photo?.loadTransferable(type: Data.self) else { return false }
            guard let (path, _) = try await StorageService.shared.saveImage(
                data: photoData,
                folder: StorageFolder.profilePictures,
                path: ImageUtil.getUniqueIdentifierForUserImage(userId: user.uid)
            ).get() else { return false }
                
            let url = try await StorageService.shared.getUrlForImage(path: path).get()
            
            let _ = await accountService.createAccount(
                account: Account(email: email, firstname: firstname, lastname: lastname, profileImage: url.absoluteString),
                id: user.uid
            )
            
            singingUp = false
            return true
        }
        catch {
            singingUp = false
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
