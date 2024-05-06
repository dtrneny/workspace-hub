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
    
//    @State var languageSettings = LanguageSetting()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .background(.white)
//                .environment(languageSettings)
//                .environment(\.locale, languageSettings.locale)
        }
    }
}
