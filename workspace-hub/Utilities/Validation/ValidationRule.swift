//
//  ValidationRule.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 08.04.2024.
//

import Foundation

protocol ValidationRule {
    associatedtype ValueType: Equatable
    
    var errorMessage: String { get }
    func isValid(value: ValueType) -> Bool
}

struct AnyValidationRule<ValueType: Equatable>: ValidationRule {
    typealias Validator = (ValueType) -> Bool
    
    let errorMessage: String
    private let isValidClosure: Validator
    
    init<R: ValidationRule>(_ base: R) where R.ValueType == ValueType {
        self.errorMessage = base.errorMessage
        self.isValidClosure = base.isValid
    }
    
    func isValid(value: ValueType) -> Bool {
        return isValidClosure(value)
    }
}
