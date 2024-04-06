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
    @Published var fruitName: String = ""
    @Published var name: String = ""
    
    init(accountService: AccountServiceProtocol) {
        self.accountService = accountService
    }
    
    
    func getAccounts() async {
        do {
            let data = try await accountService.getAccounts()
            accounts = data
        }
        catch {
            print(error)
        }
    }
}
