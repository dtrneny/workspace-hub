//
//  GroupGeneralView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 05.05.2024.
//

import SwiftUI

struct GroupGeneralView: View {
    
    let groupId: String
    
    @EnvironmentObject var coordinator: GroupCoordinator
    
    @StateObject private var viewModel = GroupGeneralViewModel(
        groupService: GroupService()
    )
    
    var body: some View {
        BaseLayout {
            switch viewModel.state {
            case .loading:
                LoadingDots(type: .view)
            default:
                ViewTitle(title: "Group informations")
                
                groupImage
                
                groupInformations
                
                VStack (spacing: 19) {
                    leaveButton
                }
            }
        }
        .confirmationDialog(
            "Do you want to leave this group?",
            isPresented: $viewModel.leaveConfirmation,
            titleVisibility: .visible
        ) {
            Button("Confirm", role: .destructive) {
                Task {
                    let _ = await viewModel.leaveGroup(groupId: groupId)
                    coordinator.replaceAll(with: [.list])
                }
            }
        }
        .routerBarBackArrowHidden(viewModel.leavingGroup)
        .onAppear {
            Task {
                await viewModel.fetchInitialData(groupId: groupId)
            }
        }
    }
}

extension GroupGeneralView {
    
    private var groupInformations: some View {
        VStack(alignment: .center, spacing: 19) {
            if let group = viewModel.group {
                Text(group.name)
                    .foregroundStyle(.secondary900)
                    .font(.inter(18.0))
                    .fontWeight(.bold)
            }
        }
        .frame(maxWidth: .infinity)
        .padding([.bottom], 38)
    }
    
    private var leaveButton: some View {
        BaseButton(content: {
            Text("Leave group")
                .font(.inter(16.0))
        }, style: .danger)
        .onTapGesture {
            viewModel.leaveConfirmation = true
        }
    }
    
    private var groupImage: some View {
        VStack(alignment: .center) {
            if let group = viewModel.group {
                HStack {
                    Spacer()
                        
                    ZStack {
                        Circle()
                            .fill(.grey300)
                            .frame(width: 125, height: 125)
                        
                        Image(systemName: group.icon)
                            .foregroundStyle(.secondary900)
                            .font(.system(size: 48))
                    }
                    .padding([.bottom], 8)
                    
                    Spacer()
                }
            }
        }
        .padding([.bottom], 19)
    }
    
}
