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
        
    private init() { }
    
    func signUp(email: String, password: String) async -> Result<User, Error> {
        do {
            let user = try await firebaseAuth.createUser(withEmail: email, password: password).user
            return .success(user)
        } catch {
            return .failure(error)
        }
    }
    
    func signIn(email: String, password: String) async -> Result<User, Error> {
        do {
            let user = try await firebaseAuth.signIn(withEmail: email, password: password).user
            return .success(user)
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
    
    func getCurrentUser() -> User? {
        guard let user = firebaseAuth.currentUser else {
            return nil
        }
        
        return user
    }
}
