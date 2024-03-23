//
//  FontExtensions.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 22.03.2024.
//

import Foundation
import SwiftUI

//enum BaseFontSize: CGFloat {
//    case label = 14.0
//    case base = 16.0
//    case viewTitle = 30.0
//}

extension Font {
    static func inter(_ size: CGFloat) -> Font {
        return Font.custom("Inter", size: size)
    }
}
