//
//  Font.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 19.03.2024.
//

import Foundation
import SwiftUI

enum BaseFont: String {
    case inter = "Inter"
}

enum BaseFontStyle: String {
    case regular = "-Regular"
    case medium = "-Medium"
    case semiBold = "-SemiBold"
}

enum BaseFontSize: CGFloat {
    case label = 14.0
    case base = 16.0
}

extension Font {
    static func baseFont(
        font: BaseFont,
        style: BaseFontStyle,
        size: BaseFontSize,
        isScaled: Bool = true
    ) -> Font {
        let fontName: String = font.rawValue + style.rawValue
        return Font.custom(fontName, size: size.rawValue)
    }
}
