//
//  BaseView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 16.03.2024.
//

import SwiftUI

struct RootView: View {
    
    @StateObject private var viewModel = RootViewModel()
    @ObservedObject var mainRouter: MainRouter = MainRouter()
    
    var body: some View {
        switch viewModel.state {
        case .loading:
            SplashView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        viewModel.state = .idle
                        
                        if (viewModel.checkForCurrentUser()) {
                            mainRouter.navigate(to: .home)
                            return
                        }
                        
                        mainRouter.navigate(to: .signIn)
                    }
                }
        default:
            RouterView<MainRouter, MainRoutes, AnyView> { route in
                AnyView(RouteFactory.viewForMainRouteDestination(route, router: mainRouter))
            }
            .environmentObject(mainRouter)
        }
    }
}

#Preview {
    RootView()
}
