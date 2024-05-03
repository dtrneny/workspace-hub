//
//  SettingAccountEditViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 27.04.2024.
//

import Foundation
import SwiftUI
import PhotosUI

final class SettingAccountEditViewModel: ViewModelProtocol {
    
    @Published var state: ViewState = .loading
    
    let accountService: AccountServiceProtocol
    
    init(accountService: AccountServiceProtocol) {
        self.accountService = accountService
    }
        
    @Published var updatingUser: Bool = false
    @Published var account: Account? = nil
    
    @Validated(rules: [nonEmptyRule])
    var firstname: String = ""
    @Published var firstnameError: String? = nil
    
    @Validated(rules: [nonEmptyRule])
    var lastname: String = ""
    @Published var lastnameError: String? = nil
    
    @Published var photo: PhotosPickerItem? = nil
    @Published var loadedImage: UIImage? = nil
    
    func fetchInitialData() async {
        await getCurrentUsersAccount()
        
        state = .idle
    }
    
    func updateAccount() async -> Bool {
        if (!$firstname.isValid() || !$lastname.isValid()) {
            firstnameError = $firstname.getError()
            lastnameError = $lastname.getError()
            
            return false
        }
        
        guard let fetchedAccount = account else {
            return false
        }
        
        guard let fetchedAccountId = fetchedAccount.id else {
            return false
        }
        
        do {
            updatingUser = true
            
            var updatedPhotoUrlString: String
            
            if (photo != nil) {
                
                guard let photoData = try await photo?.loadTransferable(type: Data.self) else {
                    updatingUser = false
                    return false
                }
                guard let (path, _) = try await StorageService.shared.saveImage(
                    data: photoData,
                    folder: StorageFolder.profilePictures,
                    path: ImageUtil.getUniqueIdentifierForUserImage(userId: fetchedAccountId)
                ).get() else {
                    updatingUser = false
                    return false
                }
                    
                let url = try await StorageService.shared.getUrlForImage(path: path).get()
                updatedPhotoUrlString = url.absoluteString
                
            } else {
                updatedPhotoUrlString = fetchedAccount.profileImage
            }
            
            let updatedAccount = Account(
                id: fetchedAccount.id,
                email: fetchedAccount.email,
                firstname: firstname,
                lastname: lastname,
                profileImage: updatedPhotoUrlString
            )
            
            let _ = await accountService.updateAccount(account: updatedAccount)
            
            updatingUser = false
            return true
            
        } catch {
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
    
    func getCurrentUsersAccount() async {
    
        let user = AuthService.shared.getCurrentUser()
        
        guard let userId = user?.uid else { return }
        
        let fetchedAccount = await accountService.getAccount(id: userId)
        
        guard let accountResult = fetchedAccount else { return }
        
        account = accountResult
        firstname = accountResult.firstname
        lastname = accountResult.lastname
        ImageUtil.loadImageFromUrl(urlString: accountResult.profileImage) { image in
            self.loadedImage = image
        }
                
        return
    }
}
