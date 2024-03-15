//
//  Fruit.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 15.03.2024.
//

import Foundation
import FirebaseFirestoreSwift

struct Fruit: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var name: String
}
