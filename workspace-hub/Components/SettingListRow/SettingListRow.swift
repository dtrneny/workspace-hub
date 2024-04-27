//
//  SettingListRow.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 26.04.2024.
//

import SwiftUI

struct SettingListRow: View {
    
    var label: String
    var action: () -> Void
    
    var body: some View {
        VStack {
            HStack(alignment: .firstTextBaseline) {
                Text(label)
                    .foregroundStyle(.secondary900)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.secondary900)
            }
            Divider()
        }
        .frame(maxWidth: .infinity)
        .padding([.bottom], 8)
        .contentShape(Rectangle())
        .onTapGesture {
            action()
        }
    }
}

#Preview {
    SettingListRow(label: "Account") {
        print("Clicked")
    }
}
