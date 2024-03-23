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
    
    func createRootUser(email: String, password: String, completion: @escaping (RootUser?, Error?) -> Void) {
        firebaseAuth.createUser(withEmail: email, password: password) { (authDataResult, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let user = authDataResult?.user else {
                completion(nil, nil)
                return
            }
            
            completion(RootUser(user: user), nil)
        }
    }
    
    func getAuthenticatedRootUser(completion: @escaping (RootUser?, Error?) -> Void) {
        guard let user = firebaseAuth.currentUser else {
            completion(nil, URLError(.badServerResponse))
            return
        }
        
        completion(RootUser(user: user), nil)
    }
    
    func signOutAuthenticatedRootUser(completion: @escaping (Bool?, Error?) -> Void) {
        do {
            try firebaseAuth.signOut()
            completion(true, nil)
        } catch let signOutError as NSError {
            completion(false, signOutError)
        }
    }
    
    func signInAuthenticatedRootUser(email: String, password: String, completion: @escaping (RootUser?, Error?) -> Void) {
        firebaseAuth.signIn(withEmail: email, password: password) { (authDataResult, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let user = authDataResult?.user else {
                completion(nil, nil)
                return
            }
            
            completion(RootUser(user: user), nil)
        }
    }
}
