//
//  GroupDetailView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 02.05.2024.
//

import SwiftUI

struct GroupDetailView: View {
    
    let groupId: String
    
    @StateObject private var viewModel = GroupDetailViewModel(
        groupService: GroupService()
    )
    
    var body: some View {
        BaseLayout {
            switch viewModel.state {
            case .loading:
                LoadingDots(type: .view)
            default:
                VStack(spacing: 38) {
                    groupOperations
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchInitialData(groupId: groupId)
            }
        }
    }
}

extension GroupDetailView {
    
    private var groupOperations: some View {
        HStack(alignment: .firstTextBaseline) {
            if let group = viewModel.group {
                ViewTitle(title: group.name)
                
                Spacer()
                
                OperationButton(icon: "plus") {
                    print("tapped")
                }
            }
        }
    }
}
