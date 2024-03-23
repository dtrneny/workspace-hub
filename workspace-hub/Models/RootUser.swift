//
//  RootUser.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 21.03.2024.
//

import Foundation
import FirebaseAuth

struct RootUser {
    var id: String
    var email: String?
    
    init(user: User) {
        self.id = user.uid
        self.email = user.email
    }
}
