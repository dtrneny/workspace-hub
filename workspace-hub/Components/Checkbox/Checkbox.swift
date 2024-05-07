//
//  Checkbox.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 07.05.2024.
//

import SwiftUI

struct Checkbox: View {
    
    let action: (_ value: Bool) -> Void
    let initialState: Bool = false
    
    @State var checked: Bool
    
    init(action: @escaping (_: Bool) -> Void, initialState: Bool) {
        self.action = action
        self.checked = initialState
    }
    
    var body: some View {
        Button {
            action(checked)
            checked = !checked
        } label: {
            if checked {
                ZStack {
                    Circle()
                        .foregroundColor(.secondary900)
                        .frame(width: 30, height: 30)
                    
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                }
                .frame(width: 32, height: 32)

                
            } else {
                ZStack {
                    Circle()
                        .stroke(Color.secondary900, lineWidth: 2)
                        .frame(width: 30, height: 30)
                }
                .frame(width: 32, height: 32)
               
            }
        }

    }
}

#Preview {
    Checkbox(action: { value in
        if (value) {
            print("checked")
        } else {
            print("unchecked")
        }
    }, initialState: false)
}
