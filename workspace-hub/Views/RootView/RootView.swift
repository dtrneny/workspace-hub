//
//  BaseView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 16.03.2024.
//

import SwiftUI

struct RootView: View {
    
    @StateObject private var viewModel = RootViewModel()
    @StateObject private var router = Router()
    
    var body: some View {
        switch viewModel.state {
        case .loading:
            SplashView()
                .onAppear {
                    // MARK: For testing purposes is there deadline, but its total UX violation
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        viewModel.state = .idle
                        router.navigate(route: .signIn)
                    }
                }
        default:
            RouterView()
                .environmentObject(router)
            
        }
    }
}

#Preview {
    RootView()
}
