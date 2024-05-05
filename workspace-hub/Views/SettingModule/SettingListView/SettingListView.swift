//
//  SettingListView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import SwiftUI

struct SettingListView: View {
    
    @EnvironmentObject var mainRouter: MainRouter
    @EnvironmentObject var coordinator: SettingCoordinator
    
    @ObservedObject private var viewModel = SettingListViewModel(accountService: AccountService())
    
    var body: some View {
        BaseLayout {
            switch viewModel.state {
            case .loading:
                LoadingDots(type: .view)
            default:
                VStack(spacing: 38) {
                    accountOperations
    
                    settings
                }
            }
        }
        .confirmationDialog(
            "Do you want to sign out?",
            isPresented: $viewModel.signOutConfirmation,
            titleVisibility: .visible
        ) {
            Button("Confirm", role: .destructive) {
                if (viewModel.signOut()) {
                    mainRouter.replaceAll(with: [.signIn])
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchInitialData()
            }
        }
    }
}

extension SettingListView {
    
    private var settings: some View {
        VStack(alignment: .leading) {
            ViewTitle(title: "Settings")

            SettingListRow(label: "Language") {
                print("Clicked")
            }
        }
    }
    
    private var accountOperations: some View {
        VStack(alignment: .leading) {
            HStack (alignment: .firstTextBaseline) {
                ViewTitle(title: "Account")
                
                Spacer()
                
                HStack (spacing: 10) {
                    OperationButton(icon: "pencil") {
                        coordinator.changeSection(to: .accountEdit)
                    }
                    OperationButton(icon: "rectangle.portrait.and.arrow.forward", color: .primaryRed700) {
                        viewModel.signOutConfirmation = true
                    }
                }
            }
            if let account = viewModel.account {
                CommonAccountListRow(
                    name: "\(account.firstname) \(account.lastname)",
                     email: account.email,
                    imageUrl: account.profileImage
                ) { EmptyView() }
            }
        }
    }
    
}

#Preview {
    SettingListView()
}
