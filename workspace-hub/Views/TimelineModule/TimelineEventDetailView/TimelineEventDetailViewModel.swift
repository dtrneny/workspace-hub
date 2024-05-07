//
//  TimelineEventDetailViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 07.05.2024.
//

import Foundation
import FirebaseFirestore

final class TimelineEventDetailViewModel: ViewModelProtocol {
    
    @Published var state: ViewState = .idle
    
    let scheduledEventService: ScheduledEventServiceProtocol
    let accountService: AccountServiceProtocol
    let groupService: GroupServiceProtocol
    
    init(
        scheduledEventService: ScheduledEventServiceProtocol,
        accountService: AccountServiceProtocol,
        groupService: GroupServiceProtocol
    ) {
        self.scheduledEventService = scheduledEventService
        self.accountService = accountService
        self.groupService = groupService
    }
    
    @Published var event: ScheduledEvent? = nil
    @Published var group: Group? = nil
    @Published var accounts: [Account] = []
    @Published var isUserScheduler: Bool = false
    
    @Published var deleteEventConfirmation: Bool = false
    
    func fetchInitialData(eventId: String) async {
        state = .loading
        
        await getAllEventInformation(eventId: eventId)
        
        if let userId = AuthService.shared.getCurrentUser()?.uid, let schedulerId = event?.scheduledBy {
            isUserScheduler = userId == schedulerId
        }
                
        state = .idle
    }
    
    func getAllEventInformation(eventId: String) async {
        event = await scheduledEventService.getScheduledEvent(id: eventId)
        
        guard let event = event, let groupId = event.groupId else {
            return
        }
        
        group = await groupService.getGroup(id: groupId)
        
        accounts = await accountService.getAccounts { query in
            query.whereField(FieldPath.documentID(), in: event.userIds)
        }
        
        await ImageUtil.loadImagesFromUrlsAsync(imageUrls: event.userImageUrls)
        
    }
    
    func deleteEvent(eventId: String) async -> Bool {
        
        return await scheduledEventService.deleteScheduledEvent(id: eventId)
    }
}
