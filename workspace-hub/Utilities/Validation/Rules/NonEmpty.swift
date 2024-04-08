//
//  NonEmpty.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 08.04.2024.
//

import Foundation

struct NonEmptyRule: ValidationRule {
    typealias ValueType = String
    
    var errorMessage: String = "Field cannot be empty"
    
    func isValid(value: ValueType) -> Bool {
        return !value.isEmpty
    }
}
