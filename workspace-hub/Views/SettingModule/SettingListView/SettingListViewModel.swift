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

    func signOut() -> Bool {
        do {
            let result = try AuthService.shared.signOut().get()
            return result
        }
        catch {
            return false
        }
    }
    
    func fetchInitialData() async {
        await getCurrentUsersAccount()
        
        state = .idle
    }
    
    func getCurrentUsersAccount() async {
        let user = AuthService.shared.getCurrentUser()
        
        guard let userId = user?.uid else { return }
        
        let fetchedAccount = await accountService.getAccount(id: userId)
        
        guard let accountResult = fetchedAccount else { return }
        
        account = accountResult
        return
    }
}
