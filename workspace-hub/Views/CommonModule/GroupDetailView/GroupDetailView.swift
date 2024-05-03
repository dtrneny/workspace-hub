//
//  GroupDetailView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 02.05.2024.
//

import SwiftUI

struct GroupDetailView: View {
    
    let groupId: String
    let navigateToSettings: () -> Void
    
    @StateObject private var viewModel = GroupDetailViewModel(
        groupService: GroupService(),
        messageService: MessageService()
    )
    
    var body: some View {
        BaseLayout {
            switch viewModel.state {
            case .loading:
                LoadingDots(type: .view)
            default:
                VStack(spacing: 38) {
                    groupOperations
                    
                    ChatLayout {
                        ScrollView {
                            ForEach(viewModel.messages, id: \.id) { message in
                                Text(message.text)
                                    .foregroundStyle(.secondary900)
                            }
                        }
                    } submitMessage: { chatSubmit in
                        Task {
                            await viewModel.sentMessage(chatSubmit: chatSubmit, groupId: groupId)
                        }
                    }

                }
            }
        }
        .onAppear {
            viewModel.getMessages(groupId: groupId)
            
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
                
                OperationButton(icon: "gearshape.fill") {
                    navigateToSettings()
                }
            }
        }
    }
}
