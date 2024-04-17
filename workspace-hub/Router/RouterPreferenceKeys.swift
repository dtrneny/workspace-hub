//
//  RouterPreferenceKeys.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 04.04.2024.
//

import Foundation
import SwiftUI

struct RouterBarBackArrowHiddenPreferenceKey: PreferenceKey {

    static var defaultValue: Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

extension View {
    func routerBarBackArrowHidden(_ hidden: Bool) -> some View {
        preference(key: RouterBarBackArrowHiddenPreferenceKey.self, value: hidden)
    }
}
