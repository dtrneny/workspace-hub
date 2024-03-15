//
//  workspace_hubApp.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 14.03.2024.
//

import SwiftUI
import Firebase

@main
struct workspace_hubApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
