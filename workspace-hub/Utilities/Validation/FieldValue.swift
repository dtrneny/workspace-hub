//
//  FieldValidation.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 08.04.2024.
//

import Foundation
import SwiftUI

struct FieldValue<ValueType: Equatable> {
    
    private var _value: ValueType
    var value: ValueType {
        get {
            return _value
        }
        set {
            _value = newValue
            isDirty = true
        }
    }
    
    var isDirty: Bool = false
    var rules: [AnyValidationRule<ValueType>]
    
    init(_ value: ValueType, isDirty: Bool = false, rules: [AnyValidationRule<ValueType>] = []) {
        self._value = value
        self.isDirty = isDirty
        self.rules = rules
    }
        
    mutating func markAsDirty() {
        isDirty = true
    }
    
    func isValid() -> Bool {
        return isDirty 
            ? rules.allSatisfy { $0.isValid(value: value) }
            : true
    }
    
    func brokenRules() -> [String] {
        return isDirty 
            ? rules
                .filter{ !$0.isValid(value: value) }
                .map{ $0.errorMessage }
            : []
    }
}
