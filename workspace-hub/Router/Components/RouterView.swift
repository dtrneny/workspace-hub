//
//  TestingRouterView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 03.04.2024.
//

import SwiftUI

struct RouterView: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        NavigationStack(path: $router.history) {
            RouterContainerView {
                EmptyView()
                    .navigationDestination(for: RouterPaths.self){ path in
                        ViewFactory.viewForDestination(path)
                    }
            }
        }
    }
}

extension UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
