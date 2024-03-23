//
//  BaseLayout.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 22.03.2024.
//

import SwiftUI

struct BaseLayout<Content: View>: View {
    @ViewBuilder let content: Content
    @ObservedObject var router: Router
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if (!router.navPath.isEmpty) {
                    BackArrow {
                        router.navigateBack()
                    }
                }
                Spacer()
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            }
            .padding([.leading, .trailing])
            .padding(.bottom, 40)
            .padding(.top, 20)
            
            content
                .padding([.leading, .trailing])
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .background(.white)
    }
}
