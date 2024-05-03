//
//  VerticalSpacer.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 03.05.2024.
//

import SwiftUI

struct VerticalSpacer: View {
    
    var height: CGFloat = 10
    
    var body: some View {
        GeometryReader { geometry in
            Color.clear.frame(height: height)
        }
    }
}

#Preview {
    VerticalSpacer()
}
