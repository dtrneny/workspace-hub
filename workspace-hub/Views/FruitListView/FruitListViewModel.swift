//
//  FruitListViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 15.03.2024.
//

import Foundation
import SwiftUI

@MainActor
class FruitListViewModel: ViewModelProtocol {
    
    let accountService: AccountServiceProtocol

    @Published var accounts: [Account] = []
    @Published var state: ViewState = .idle

    init(accountService: AccountServiceProtocol) {
        self.accountService = accountService
    }
    
    func getAccounts() async {
        accounts = await accountService.getAccounts()
    }
}
