//
//  RootViewmodel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 18.03.2024.
//

import Foundation
import Firebase

class RootViewModel: ViewModelProtocol {
    @Published var state: ViewState = .loading
    
    init() {
        FirebaseApp.configure()
    }

}
