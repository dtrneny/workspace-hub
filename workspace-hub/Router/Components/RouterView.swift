//
//  TestingRouterView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 03.04.2024.
//

import SwiftUI

struct RouterView<Router: RouterProtocol, Routes: Hashable, RenderedContent: View>: View {
    
    @EnvironmentObject var router: Router
    
    let renderedContent: (Routes) -> RenderedContent
    
    var body: some View {
        NavigationStack(path: $router.history) {
            RouterContainerView(content: {
                Color.clear
                .navigationDestination(for: Routes.self) { route in
                    renderedContent(route)
                }
            }, router: router)
        }
    }
}

// MARK: You can swipe out of home to empty page,
// MARK: so this part should communicate with router
//extension UINavigationController {
//    open override func viewDidLoad() {
//        super.viewDidLoad()
//        interactivePopGestureRecognizer?.delegate = nil
//    }
//}
