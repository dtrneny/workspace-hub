//
//  SettingListViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import Foundation

final class SettingListViewModel: ViewModelProtocol {
    
    @Published var state: ViewState = .loading
    
    let accountService: AccountServiceProtocol
    
    init(accountService: AccountServiceProtocol) {
        self.accountService = accountService
    }
    
    @Published var account: Account? = nil
    @Published var signOutConfirmation: Bool = false

    func signOut() -> Bool {
        do {
            let result = try AuthService.shared.signOut().get()
            signOutConfirmation = false
            return result
        }
        catch {
            return false
        }
    }
    
    func fetchInitialData() async {
        state = .loading
        
        await getCurrentUsersAccount()
        
        state = .idle
    }
    
    func getCurrentUsersAccount() async {
        let user = AuthService.shared.getCurrentUser()
        
        guard let userId = user?.uid else { return }
        
        let fetchedAccount = await accountService.getAccount(id: userId)
        
        
        if let fetchedAccount = fetchedAccount {
            await ImageUtil.loadImageFromUrlAsyncToCache(urlString: fetchedAccount.profileImage)
            account = fetchedAccount
        }
        
        return
    }
}
