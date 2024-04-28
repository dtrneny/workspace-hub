//
//  ThemeColorPicker.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 26.04.2024.
//

import SwiftUI

struct ThemeColorPicker: View {
    
    @Binding var selectedColor: UIColor
    
    var body: some View {
        HStack(spacing: 19) {
            ForEach(ThemeColorUtil.getThemeUIColors(), id: \.self) { color in
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
