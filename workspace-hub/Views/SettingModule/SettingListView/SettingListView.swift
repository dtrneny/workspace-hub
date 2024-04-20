//
//  SettingListView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import SwiftUI

struct SettingListView: View {
    
    @EnvironmentObject var mainRouter: MainRouter
    @ObservedObject private var viewModel = SettingListViewModel()
    
    
    var body: some View {
        VStack {
            Button("Sign Out") {
                if (viewModel.signOut()) {
                    mainRouter.replaceAll(with: .signIn)
                }
            }
            .filledButtonStyle()
            TextField("Test", text: $viewModel.username)
                .foregroundStyle(.grey800)
            
            if (viewModel.usernameError != nil) {
                ErrorMessage(error: viewModel.usernameError!)
            }
            Button("test") {
                viewModel.submitForm()
            }
        }
    }
}

#Preview {
    SettingListView()
}
