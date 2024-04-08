//
//  FruitListView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 15.03.2024.
//

import SwiftUI

struct FruitListView: View {
    
    @StateObject private var viewModel = FruitListViewModel(accountService: AccountService())
    
    var body: some View {
        BaseLayout {
            Section {
                HStack {
                    Button("Test") {
                        Task {
                            await viewModel.getAccounts()
                        }
                    }
                }.padding(16)
                
            }
            Divider()
            List(viewModel.accounts, id: \.id) { account in
                Text(account.fullname)
            }
            .onAppear {
                Task {
                    await viewModel.getAccounts()
                }
            }
            
        }
    }
}

// MARK: add mock
//#Preview {
//
//    struct Preview: View {
//        var body: some View {
//            FruitListView()
//        }
//    }
//    
//    return Preview()
//}
