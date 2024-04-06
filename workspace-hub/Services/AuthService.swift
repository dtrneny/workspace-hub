//
//  AuthService.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 21.03.2024.
//

import Foundation
import FirebaseAuth

final class AuthService {
    
    static let shared = AuthService()
    private let firebaseAuth = Auth.auth()
    private let accountService: AccountServiceProtocol = AccountService()
        
    private init() { }
    
    func signUp(email: String, password: String, fullname: String) async -> Result<Account?, Error> {
        do {
            let user = try await firebaseAuth.createUser(withEmail: email, password: password).user
            let account = await accountService.createAccount(account: Account(id: user.uid, email: email, fullname: fullname), id: user.uid)
            return .success(account ?? nil)
        } catch {
            return .failure(error)
        }
    }
    
    func signIn(email: String, password: String) async -> Result<Account?, Error> {
        do {
            let user = try await firebaseAuth.signIn(withEmail: email, password: password).user
            let account = await accountService.getAccount(id: user.uid)
            return .success(account)
        } catch {
            return .failure(error)
        }
    }
    
    func signOut() -> Result<Bool, Error> {
        do {
            try firebaseAuth.signOut()
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
    
    func getCurrentUser() async -> Result<User?, Error> {
        guard let user = firebaseAuth.currentUser else {
            return .success(nil)
        }
        return .success(user)
    }
}
