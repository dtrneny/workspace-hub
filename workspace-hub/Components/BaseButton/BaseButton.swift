//
//  BaseButton.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 25.04.2024.
//

import SwiftUI

enum BaseButtonStyle {
    case filled
    case outlined
    case danger
}

struct BaseButton<Content: View>: View {
    
    let action: () -> Void
    let content: Content
    let style: BaseButtonStyle
    
    init(
        action: @escaping () -> Void,
        content: () -> Content,
        style: BaseButtonStyle = .filled
    ) {
        self.action = action
        self.content = content()
        self.style = style
    }
    
    var body: some View {
        VStack(alignment: .center) {
            content
        }
        .if(style == .filled) { view in
            view.modifier(FilledBaseButton())
        }
        .if(style == .outlined) { view in
            view.modifier(OutlinedBaseButton())
        }
        .if(style == .danger) { view in
            view.modifier(DangerBaseButton())
        }
        .onTapGesture {
            action()
        }
    }
}

struct FilledBaseButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .padding()
            .background(.secondary900)
            .cornerRadius(10)
            .font(.inter(16.0))
            .fontWeight(.semibold)
    }
}

struct OutlinedBaseButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .foregroundColor(.secondary900)
            .padding()
            .background(
                RoundedRectangle(
                    cornerRadius: 10,
                    style: .continuous
                )
                .stroke(.secondary900, lineWidth: 1)
            )
            .font(.inter(16.0))
            .fontWeight(.semibold)
    }
}

struct DangerBaseButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .foregroundColor(.primaryRed700)
            .padding()
            .background(
                RoundedRectangle(
                    cornerRadius: 10,
                    style: .continuous
                )
                .stroke(.primaryRed700, lineWidth: 1)
                .foregroundStyle(.primaryRed700.opacity(0.05))
            )
            .font(.inter(16.0))
            .fontWeight(.semibold)
    }
}

#Preview {
    BaseButton {
        print("touched")
    } content: {
        HStack (spacing: 8) {
            ProgressView()
                .tint(.white)
            Text("Testing button")
        }
    }
}
