//
//  EmailFormat.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 05.05.2024.
//

import Foundation

func emailRule(value: String) -> String {
    let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: value)
        ? ""
        : NSLocalizedString("Please enter a valid email address.", comment: "")
}
