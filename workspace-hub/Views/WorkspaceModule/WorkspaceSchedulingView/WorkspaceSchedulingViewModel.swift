//
//  WorkspaceSchedulingViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 06.05.2024.
//

import Foundation
import FirebaseFirestore

final class WorkspaceSchedulingViewModel: ViewModelProtocol {
    
    @Published var state: ViewState = .loading
    
    let scheduledEventService: ScheduledEventServiceProtocol
    let workspaceService: WorkspaceServiceProtocol
    let groupService: GroupServiceProtocol
    let accountService: AccountServiceProtocol
    
    init(
        scheduledEventService: ScheduledEventServiceProtocol,
        workspaceService: WorkspaceServiceProtocol,
        groupService: GroupServiceProtocol,
        accountService: AccountServiceProtocol
    ) {
        self.scheduledEventService = scheduledEventService
        self.workspaceService = workspaceService
        self.groupService = groupService
        self.accountService = accountService
    }
    
    @Validated(rules: [nonEmptyRule])
    var eventTitle: String = ""
    @Published var eventTitleError: String? = nil
    
    @Validated(rules: [])
    var eventDescription: String = ""
    @Published var eventDescriptionError: String? = nil
    
    @Published var startAt: Date = Date()
    @Published var startAtError: String? = nil
    
    @Published var endAt: Date = Date()
    @Published var endAtError: String? = nil
    
    @Published var selectedGroupId: String? = nil
    
    var selectedGroup: Group? {
        if let id = selectedGroupId {
            return groups.first { group in
                group.id == id
            }
        }
        
        return nil
    }
    
    @Published var groupError: String? = nil
    
    @Published var schedulingEvent: Bool = false

    @Published var workspace: Workspace? = nil
    @Published var groups: [Group] = []
    @Published var selectedAccountIds: [String] = []
    
    private var allAccounts: [Account] = []
    
    var presentedAccounts: [Account] {
        if let memberIds = selectedGroup?.memberIds {
            return allAccounts.filter {
                if let id = $0.id {
                    return memberIds.contains(id)
                } else {
                    return false
                }
            }
        }
        
        return []
    }
    
    func fetchInitialData(workspaceId: String) async {
        state = .loading
        
        await getWorkspace(workspaceId: workspaceId)
        await getGroups()
        
        state = .idle
    }
    
    func getWorkspace(workspaceId: String) async {
        workspace = await workspaceService.getWorkspace(id: workspaceId)
    }
    
    func getGroups() async {
        guard let groupIds = workspace?.groups else {
            return
        }
        
        guard !groupIds.isEmpty else {
            return
        }
        
        groups = await groupService.getGroups(assembleQuery: { query in
            query.whereField(FieldPath.documentID(), in: groupIds)
        })
    }
    
    func getGroupAccounts() async {
        guard let memberIds = selectedGroup?.memberIds else {
            return
        }
        
        guard !memberIds.isEmpty else {
            return
        }
        
        state = .loading
        
        selectedAccountIds = []
        
        let accounts = await accountService.getAccounts { query in
            query.whereField(FieldPath.documentID(), in: memberIds)
        }
        
        if (!accounts.isEmpty) {
            let imageUrls = accounts.map { account in
                account.profileImage
            }
            
            await ImageUtil.loadImagesFromUrlsAsync(imageUrls: imageUrls)
        }
        
        var uniqueAccounts: [Account] = []
        
        for account in accounts {
            var isDuplicate = false
            for existingAcc in allAccounts {
                if (account.id == existingAcc.id) {
                    isDuplicate = true
                    break
                }
            }
            if !isDuplicate {
                uniqueAccounts.append(account)
            }
        }
        
        allAccounts.append(contentsOf: uniqueAccounts)
                
        state = .idle
    }
    
    func appendAccountId(accountId: String) {
        selectedAccountIds.append(accountId)
    }
    
    func fillterOutAccountId(accountId: String) {
        selectedAccountIds = selectedAccountIds.filter { $0 != accountId }
    }
    
    func scheduleEvent(workspaceId: String) async -> Bool {
        endAtError = nil
        eventTitleError = nil
        eventDescriptionError = nil
        groupError = nil

        
        if (!$eventTitle.isValid() || !$eventDescription.isValid()) {
            eventTitleError = $eventTitle.getError()
            eventDescriptionError = $eventDescription.getError()
            
            return false
        }
        
        guard DateUtil.isAfterByAtLeast(date2: endAt, date1: startAt, atlest: 5) else {
            endAtError = NSLocalizedString("Please choose a date which is atlest 5 minutes after start.", comment: "")
            return false
        }
        
        guard let groupId = selectedGroup?.id else {
            groupError = NSLocalizedString("Please choose a group.", comment: "")
            return false
        }
        
        guard let userId = AuthService.shared.getCurrentUser()?.uid else {
            schedulingEvent = false
            return false
        }
        
        schedulingEvent = true
        
        let _ = await scheduledEventService.scheduleEvent(event: ScheduledEvent(
            workspaceId: workspaceId,
            groupId: groupId,
            userIds: selectedAccountIds,
            startAt: startAt,
            endAt: endAt,
            title: eventTitle,
            description: eventDescription,
            scheduledBy: userId
        ))
        
        schedulingEvent = false
        return true
    }
}
