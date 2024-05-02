//
//  GroupSettingsView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 02.05.2024.
//

import SwiftUI

struct GroupSettingListView: View {
    
    let groupId: String
    
    var body: some View {
        BaseLayout {
            VStack(spacing: 38) {
                
                settings
                
            }
        }
    }
}

extension GroupSettingListView {
    
    private var settings: some View {
        VStack(alignment: .leading) {
            ViewTitle(title: "Group settings")

            SettingListRow(label: "General") {
                print("Clicked")
            }
            SettingListRow(label: "Participants") {
                print("Clicked")
            }
        }
    }
}
