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
            VStack(spacing: 38) {
                VStack(alignment: .leading) {
                    HStack (alignment: .firstTextBaseline) {
                        ViewTitle(title: "Account")
                        
                        Spacer()
                        
                        HStack (spacing: 10) {
                            OperationButton(icon: "pencil") {
                                coordinator.changeSection(to: .accountEdit)
                            }
                            OperationButton(icon: "rectangle.portrait.and.arrow.forward", color: .primaryRed700) {
                                if (viewModel.signOut()) {
                                    mainRouter.replaceAll(with: [.signIn])
                                }
                            }
                        }
                    }
                    if let account = viewModel.account {
                        SettingAccountCard(
                            name: "\(account.firstname) \(account.lastname)",
                            email: account.email,
                            imageUrl: account.profileImage
                        )
                    }
                }
                
                VStack(alignment: .leading) {
                    ViewTitle(title: "Settings")

                    SettingListRow(label: "Notifications") {
                        print("Clicked")
                    }
                    SettingListRow(label: "Language") {
                        print("Clicked")
                    }
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.getCurrentUsersAccount()
            }
        }
    }
}

#Preview {
    SettingListView()
}
