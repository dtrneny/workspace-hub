//
//  ThemeColorPicker.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 26.04.2024.
//

import SwiftUI

struct ThemeColorPicker: View {
    
    @Binding var selectedColor: UIColor
    private let themeColors: [UIColor] = [
        UIColor(.primaryRed700),
        UIColor(.primaryGreen700),
        UIColor(.primaryViolet700),
        UIColor(.primaryYellow700),
    ]
    
    var body: some View {
        HStack(spacing: 19) {
            ForEach(themeColors, id: \.self) { color in
                Color(color)
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())
                    .onTapGesture {
                        selectedColor = color
                    }
            }
        }
    }
}

#Preview {
    
    @State var selectedColor: UIColor = UIColor(.primaryRed700)
    
    return VStack {
        ThemeColorPicker(selectedColor: $selectedColor)
            .padding()
        
        Color(selectedColor)
            .frame(width: 60, height: 60)
    }
}
