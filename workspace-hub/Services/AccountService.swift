//
//  AccountService.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 05.04.2024.
//

import Foundation
import FirebaseFirestore

protocol AccountServiceProtocol {
    func getAccounts(assembleQuery: @escaping (Query) -> Query) async -> [Account]
    func createAccount(account: Account, id: String) async -> Account?
    func getAccount(id: String) async -> Account?
    func updateAccount(account: Account) async -> Account?
}

class AccountService: AccountServiceProtocol, ObservableObject {
    
    private var repository = FirestoreRepository<Account>(collection: "accounts")
    
    func getAccounts(assembleQuery: @escaping (Query) -> Query) async -> [Account] {
        do {
            return try await repository.fetchData(assembleQuery: assembleQuery).get()
        } catch {
            return []
        }
    }
    
    func createAccount(account: Account, id: String) async -> Account? {
        do {
            let account = try await repository.create(data: account, id: id).get()
            return account
        }
        catch {
            return nil
        }
    }
    
    func getAccount(id: String) async -> Account? {
        do {
            let account = try await repository.getById(id: id).get()
            return account
        }
        catch {
            return nil
        }
    }
    
    func updateAccount(account: Account) async -> Account? {
        do {
            guard let id = account.id else {
                return nil
            }
            
            let account = try await repository.update(id: id, data: account).get()
            return account
        }
        catch {
            return nil
        }
    }
}

