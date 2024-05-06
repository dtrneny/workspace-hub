//
//  NonEmpty.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 08.04.2024.
//

import Foundation

func nonEmptyRule(value: String) -> String {
    return !value.isEmpty
        ? ""
        : NSLocalizedString("Please do not leave this field empty.", comment: "")
}
