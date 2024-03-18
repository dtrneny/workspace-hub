//
//  BaseView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 16.03.2024.
//

import SwiftUI

struct RootView: View {
    
    @StateObject private var viewModel = RootViewModel()
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                SplashView()
            default:
                FruitListView()
            }
        }
        .onAppear {
            // MARK: For testing purposes is there deadline, but its total UX violation
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                viewModel.state = .idle
            }
        }
    }
}

#Preview {
    RootView()
}
