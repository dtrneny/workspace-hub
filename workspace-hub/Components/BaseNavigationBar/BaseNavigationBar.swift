//
//  RouterBar.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 04.04.2024.
//

import SwiftUI

struct BaseNavigationBar: View {
    
    let showBack: Bool
    var action: () -> Void
    
    var body: some View {
        HStack {
            if(showBack) {
                BackArrow {
                    action()
                }
            }
            Spacer()
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
        }
        .padding()
        .padding([.bottom], 19)
        .background(Color.white.ignoresSafeArea(edges: .top))
    }
}

#Preview {
    VStack {
        BaseNavigationBar(showBack: true) {
            print("back")
        }
        Spacer()
    }
}
