//
//  LoadingSpinner.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 28.04.2024.
//

import SwiftUI

enum LoadingDotsType {
    case view
}

struct LoadingDots: View {
    
    @State var animate = false
    
    var type: LoadingDotsType? = nil
    
    let themeColors = ThemeColorUtil.getThemeUIColors()
    
    var body: some View {
        VStack {
            switch type {
            case .view:
                VStack {
                    Spacer()
                    
                    dots
                        .padding([.bottom], 120)
                    
                    Spacer()
                }
            default:
                dots
            }
        }
        .onAppear {
            animate = true
        }
    }
}

extension LoadingDots {
    
    private var dots: some View {
        HStack {
            ForEach(themeColors.indices, id: \.self) { index in
                Circle()
                    .foregroundStyle(Color(uiColor: themeColors[index]))
                    .frame(width: 12, height: 12)
                    .scaleEffect(animate ? 1.2 : 1)
                    .offset(y: animate ? -13 : 13)
                    .animation(
                        .easeInOut(duration: 0.4)
                            .repeatForever()
                            .delay(0.1 * Double(index)),
                        value: animate
                    )

            }
        }
    }
    
}

