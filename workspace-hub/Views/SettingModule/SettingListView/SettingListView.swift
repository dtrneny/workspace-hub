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
            Text("list")
            Button("Sign Out") {
                if (viewModel.signOut()) {
                    mainRouter.replaceAll(with: .signIn)
                }
            }
            .filledButtonStyle()
        }
    }
}

#Preview {
    SettingListView()
}
