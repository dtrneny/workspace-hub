//
//  SplashView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 18.03.2024.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack {
            Spacer()
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .padding(.bottom, 100)
            Spacer()
            ProgressView()
                .tint(.white)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.secondary900)
    }
}

#Preview {
    SplashView()
}
