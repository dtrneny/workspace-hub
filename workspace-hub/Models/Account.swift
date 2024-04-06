//
//  Account.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 05.04.2024.
//

import Foundation
import FirebaseFirestoreSwift

struct Account: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var email: String
    var fullname: String
}
