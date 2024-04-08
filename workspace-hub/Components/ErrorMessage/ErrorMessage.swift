//
//  ErrorMessage.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 08.04.2024.
//

import Foundation
import SwiftUI

struct ErrorMessage: View {
    var error: String
    
    var body: some View {
        Text(error)
            .font(.inter(10.0))
            .foregroundColor(.red)
    }
}

#Preview {
    ErrorMessage(error: "Error message here!")
}
