//
//  GroupDetailViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 02.05.2024.
//

import Foundation

final class GroupDetailViewModel: ViewModelProtocol {
    
    @Published var state: ViewState = .loading
    
    let groupService: GroupServiceProtocol
    let messageService: MessageServiceProtocol
    
    init(groupService: GroupServiceProtocol, messageService: MessageServiceProtocol) {
        self.groupService = groupService
        self.messageService = messageService
    }
    
    @Published var group: Group? = nil
    @Published var messages: [Message] = []
    
    func fetchInitialData(groupId: String) async {
        state = .loading
        
        guard let fetchedGroup = await getGroup(groupId: groupId) else  {
            state = .error(message: "Group not found.")
            return
        }
        
        group = fetchedGroup
        
        state = .idle
    }
    
    func getGroup(groupId: String) async -> Group? {
        let group = await groupService.getGroup(id: groupId)
        return group
    }
    
    func sentMessage(chatSubmit: ChatSubmit, groupId: String) async -> Bool {
        let message = await messageService.createMessage(message: Message(
            userId: "3DMOijappVXLZ4mBp4Dx8nLBKP73",
            text: chatSubmit.text,
            sentAt: chatSubmit.sentAt,
            groupId: groupId
        ))
        return message != nil
    }
    
    func getMessages(groupId: String) {
        messageService.getGroupMessages { query in
            return query.whereField("groupId", isEqualTo: groupId)
        } completion: { [weak self] fetchedMessages, error in
            guard let self = self else { return }
            messages = fetchedMessages
        }
//
//        
//        messageService.getActiveMessages { [weak self] fetchedMessages, error in
//            guard let self = self else { return }
//            messages = fetchedMessages
//        }
    }
}
