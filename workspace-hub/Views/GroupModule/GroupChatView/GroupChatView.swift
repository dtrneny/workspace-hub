//
//  GroupChatView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 05.05.2024.
//

import SwiftUI

struct GroupChatView: View {
    
    let groupId: String
    
    @EnvironmentObject var coordinator: GroupCoordinator
    
    @StateObject private var viewModel = GroupChatViewModel(
        groupService: GroupService(),
        messageService: MessageService(),
        accountService: AccountService()
    )
    
    @State var changedChatFocus: Bool = false

    var body: some View {
        BaseLayout {
            switch viewModel.state {
            case .loading:
                LoadingDots(type: .view)
            default:
                VStack(spacing: 38) {
                    groupOperations
                    
                    ChatLayout {
                        if (viewModel.chatItemGroups.isEmpty) {
                            EmptyChatPlaceholder()
                        } else {
                            ScrollView {
                                ScrollViewReader { scrollView in
                                    ForEach(viewModel.chatItemGroups, id: \.id) { chatItemGroup in
                                        VStack {
                                            ForEach(chatItemGroup.chatItems, id: \.id) { chatItem in
                                                ChatMessage(chatItem: chatItem)
                                            }
                                            VerticalSpacer(height: 15)
                                        }
                                        .if(viewModel.lastChatGroup != nil && viewModel.lastChatGroup!.id == chatItemGroup.id) { stack in
                                            stack.padding([.bottom], 28)
                                        }
                                    }
                                    .onAppear {
                                        if let lastItem = viewModel.lastChatGroup {
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

extension GroupChatView {
    
    private var groupOperations: some View {
        HStack(alignment: .firstTextBaseline) {
            if let group = viewModel.group {
                DynamicViewTitle(title: group.name)
                
                Spacer()
                
                OperationButton(icon: "gearshape.fill") {
                    coordinator.changeSection(to: .groupSettings(groupId: groupId))
                }
            }
        }
    }
}
