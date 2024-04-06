//
//  RouterBar.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 04.04.2024.
//

import SwiftUI

struct RouterBar: View {
    
    @EnvironmentObject var router: Router
    let showBack: Bool
    
    var body: some View {
        HStack {
            if(showBack) {
                BackArrow {
                    router.pop()
                }
            }
            Spacer()
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
        }
        .padding()
        .padding([.bottom], 38)
        .background(Color.white.ignoresSafeArea(edges: .top))
    }
}

#Preview {
    VStack {
        RouterBar(showBack: true)
        Spacer()
    }
    .environmentObject(Router())
}
