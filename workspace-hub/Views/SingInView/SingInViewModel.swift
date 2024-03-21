//
//  SingInViewModel.swift
//  workspace-hub
//
//  Created by František on 21.03.2024.
//

import Foundation
import SwiftUI

class SignInViewModel: ViewModelProtocol {
    @Published var state: ViewState = .idle
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var rememberMe: Bool = false
}
