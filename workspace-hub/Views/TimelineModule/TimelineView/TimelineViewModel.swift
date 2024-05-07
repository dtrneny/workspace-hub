//
//  TimelineViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 07.05.2024.
//

import SwiftUI

final class TimelineViewModel: ViewModelProtocol {
    
    @Published var state: ViewState = .idle
    
    let scheduledEventService: ScheduledEventServiceProtocol
    
    init(scheduledEventService: ScheduledEventServiceProtocol) {
        self.scheduledEventService = scheduledEventService
    }
    
    private var today: Date = Date()
    
    @Published var selectedDate: Date = Date()
    @Published var selectedMonth: Date = {
        let calendar = Calendar.current
        let currentDate = Date()
        let components = calendar.dateComponents([.year, .month], from: currentDate)
        return calendar.date(from: components)!
    }()
    
    @Published var plannedByUser: [ScheduledEvent] = []
    @Published var plannedFromOthers: [ScheduledEvent] = []
    
    @Published var presentedFromOthers: Bool = false
    
    var plannedByUserPresented: [ScheduledEvent] {
        return filterAndSortEvents(events: plannedByUser)
    }
    
    var plannedFromOthersPresented: [ScheduledEvent] {
        return filterAndSortEvents(events: plannedFromOthers)
    }
    
    func fetchInitialData() async {
        state = .loading
        
        plannedByUser = await getEventsByUser()
        plannedFromOthers = await getEventsFromOthers()
        
        let firstUrlSet = Set(plannedByUser.flatMap({ event in
            event.userImageUrls
        }))
        
        let secondUrlSet = Set(plannedFromOthers.flatMap({ event in
            event.userImageUrls
        }))
        
        let combined = firstUrlSet.union(secondUrlSet)
        
        await ImageUtil.loadImagesFromUrlsAsync(imageUrls: Array(combined))
                
        state = .idle
    }
    
    func getEventsByUser() async -> [ScheduledEvent] {
        guard let userId = AuthService.shared.getCurrentUser()?.uid else {
            return []
        }
        
        return await scheduledEventService.getScheduledEvents { query in
            query.whereField("scheduledBy", isEqualTo: userId)
        }
    }
    
    func getEventsFromOthers() async -> [ScheduledEvent] {
        guard let userId = AuthService.shared.getCurrentUser()?.uid else {
            return []
        }
        
        return await scheduledEventService.getScheduledEvents { query in
            query.whereField("userIds", arrayContains: userId)
        }
    }
    
    func filterAndSortEvents(events: [ScheduledEvent]) -> [ScheduledEvent] {
        let calendar = Calendar.current
        let selectedDayAndMonthComponents = calendar.dateComponents([.day, .month], from: selectedDate)

        let filteredEvents = events.filter { event in
            let eventStartComponents = calendar.dateComponents([.day, .month], from: event.startAt)
            let eventEndComponents = calendar.dateComponents([.day, .month], from: event.endAt)

            let selectedDay = selectedDayAndMonthComponents.day
            let selectedMonth = selectedDayAndMonthComponents.month
            let eventStartDay = eventStartComponents.day
            let eventStartMonth = eventStartComponents.month
            let eventEndDay = eventEndComponents.day
            let eventEndMonth = eventEndComponents.month

            let isStartDayEqual = selectedDay == eventStartDay && selectedMonth == eventStartMonth
            let isEndDayEqual = selectedDay == eventEndDay && selectedMonth == eventEndMonth

            return (event.startAt <= selectedDate && event.endAt > selectedDate) || isStartDayEqual || isEndDayEqual
        }

        let sortedEvents = filteredEvents.sorted { $0.startAt < $1.startAt }
        return sortedEvents
    }
    
    func resetTimeline () {
        selectedDate = today
        
        selectedMonth = {
            let calendar = Calendar.current
            let currentDate = Date()
            let components = calendar.dateComponents([.year, .month], from: currentDate)
            return calendar.date(from: components)!
        }()
    }
    
    func nextMonth () {
        selectedMonth = DateUtil.nextMonth(from: selectedMonth)
        
        if let firstDay = firstDateOfMonth(year: selectedMonth.year, month: selectedMonth.month) {
            selectedDate = firstDay
        }
    }
    
    func previousMonth () {
        selectedMonth = DateUtil.previousMonth(from: selectedMonth)
        
        if let firstDay = firstDateOfMonth(year: selectedMonth.year, month: selectedMonth.month) {
            selectedDate = firstDay
        }
    }
    
    func firstDateOfMonth(year: Int, month: Int) -> Date? {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = 1
        return calendar.date(from: components)
    }
}

