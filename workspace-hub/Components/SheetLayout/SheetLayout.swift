//
//  SheetLayout.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 20.04.2024.
//

import SwiftUI

struct SheetLayout<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            content
            Spacer()
        }
        .padding()
        .presentationBackground(.white)
    }
}

#Preview {
    SheetLayout{
        Text("testing")
    }
}
