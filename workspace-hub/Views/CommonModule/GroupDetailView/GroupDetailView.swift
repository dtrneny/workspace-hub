//
//  GroupDetailView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 02.05.2024.
//

import SwiftUI

struct GroupDetailView: View {
    
    let workspaceId: String
    let groupId: String
    let navigateToSettings: () -> Void
    
    @StateObject private var viewModel = GroupDetailViewModel(
        groupService: GroupService(),
        messageService: MessageService(),
        accountService: AccountService()
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
                            ScrollViewReader { scrollView in
                                ForEach(viewModel.chatItemGroups, id: \.id) { chatItemGroup in
                                    VStack {
                                        ForEach(chatItemGroup.chatItems, id: \.id) { chatItem in
                                            ChatMessage(chatItem: chatItem)
                                        }
                                        VerticalSpacer(height: 15)
                                    }
                                    .onAppear {
                                        if let lastItem = viewModel.lastChatItem {
                                            scrollView.scrollTo(lastItem.id, anchor: .bottom)
                                        }
                                    }
                                }
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
