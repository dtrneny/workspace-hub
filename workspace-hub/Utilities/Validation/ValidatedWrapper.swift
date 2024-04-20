//
//  FieldWrapper.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 19.04.2024.
//

import Foundation
import SwiftUI

@propertyWrapper
struct Validated<T> {
    
    private var _wrappedValue: T
    private let rules: [(T) -> String]
    var errors: [String] = []
    
    var wrappedValue: T {
        get { _wrappedValue }
        set {
            _wrappedValue = newValue
        }
    }
    
    mutating func validate() {
        errors.removeAll()
        
        rules.forEach { rule in
            let result = rule(_wrappedValue)
            if !result.isEmpty {
                errors.append(result)
            }
        }
    }
    
    mutating func isValid() -> Bool {
        validate()
        return errors.isEmpty
    }
    
    func getError() -> String? {
        return errors.count > 0
            ? errors[0]
            : nil
    }
    
    var projectedValue: Validated<T> {
        get { self }
        set { self = newValue }
    }
    
    init(wrappedValue: T, rules: [(T) -> String]) {
        self._wrappedValue = wrappedValue
        self.rules = rules
        validate()
    }
}
