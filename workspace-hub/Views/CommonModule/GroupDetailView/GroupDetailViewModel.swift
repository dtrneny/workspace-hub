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
    let accountService: AccountServiceProtocol
    
    init(
        groupService: GroupServiceProtocol,
        messageService: MessageServiceProtocol,
        accountService: AccountServiceProtocol
    ) {
        self.groupService = groupService
        self.messageService = messageService
        self.accountService = accountService
    }
    
    @Published var group: Group? = nil
    @Published var currentUserAccount: Account? = nil
    @Published var chatItemGroups: [ChatItemGroup] = []
    @Published var lastChatItem: ChatItem? = nil
    
    func fetchInitialData(groupId: String) async {
        state = .loading
        
        guard let fetchedGroup = await getGroup(groupId: groupId) else  {
            state = .error(message: "Group not found.")
            return
        }
        
        await getCurrentUsersAccount()
        getMessages(groupId: groupId)
        
        group = fetchedGroup
        
        state = .idle
    }
    
    func getGroup(groupId: String) async -> Group? {
        let group = await groupService.getGroup(id: groupId)
        return group
    }
    
    func sentMessage(chatSubmit: ChatSubmit, groupId: String) async -> Bool {
        
        guard let account = currentUserAccount, let userId = currentUserAccount?.id else {
            return false
        }
        
        let message = await messageService.createMessage(message: Message(
            userId: userId,
            text: chatSubmit.text,
            sentAt: chatSubmit.sentAt,
            groupId: groupId,
            userPhotoUrlString: account.profileImage,
            fullname: "\(account.firstname) \(account.lastname)"
        ))
        return message != nil
    }
    
    func getMessages(groupId: String) {
        guard let userId = currentUserAccount?.id else {
            return
        }
        
        messageService.getGroupMessages { query in
            return query.whereField("groupId", isEqualTo: groupId)
        } completion: { [weak self] fetchedMessages, error in
            guard let self = self else { return }
            chatItemGroups = ChatUtil.getChatItemGroupsFromMessages(messages: fetchedMessages, currentUserId: userId)
            lastChatItem = getLastChatItem(groups: chatItemGroups)
        }
    }
    
    func getCurrentUsersAccount() async {
        let user = AuthService.shared.getCurrentUser()
        
        guard let userId = user?.uid else { return }
        
        let account = await accountService.getAccount(id: userId)
        
        currentUserAccount = account
    }
    
    private func getLastChatItem (groups: [ChatItemGroup]) -> ChatItem? {
        
        if let lastGroup = groups.last {
            if let lastItem = lastGroup.chatItems.last {
                return lastItem
            }
        }
        
        return nil
    }
}
