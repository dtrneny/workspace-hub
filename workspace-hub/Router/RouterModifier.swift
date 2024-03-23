//
//  RouterView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 22.03.2024.
//

import SwiftUI

struct RouterModifier: ViewModifier {
    @ObservedObject var router: Router
    
    func body(content: Content) -> some View {
        NavigationStack(path: $router.navPath) {
            content
                .environmentObject(router)
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .signIn:
                        SignInView()
                            .navigationBarBackButtonHidden(true)
                            .environmentObject(router)
                    case .onBoarding:
                        OnboardingView()
                            .navigationBarBackButtonHidden(true)
                            .environmentObject(router)
                    case .signUp:
                        SignUpView()
                            .navigationBarBackButtonHidden(true)
                            .environmentObject(router)
                    case .fruitList:
                        FruitListView()
                            .navigationBarBackButtonHidden(true)
                            .environmentObject(router)
                    }
                }
            }
        }
}
