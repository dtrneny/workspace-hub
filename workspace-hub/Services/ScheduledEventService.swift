//
//  ScheduledEventService.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 06.05.2024.
//

import Foundation
import FirebaseFirestore

protocol ScheduledEventServiceProtocol {
    func getScheduledEvents(assembleQuery: @escaping (Query) -> Query) async -> [ScheduledEvent]
    func scheduleEvent(event: ScheduledEvent) async -> ScheduledEvent?
    func getScheduledEvent(id: String) async -> ScheduledEvent?
    func updateScheduledEvent(id: String, update: ScheduledEvent) async -> ScheduledEvent?
    func deleteScheduledEvent(id: String) async -> Bool
}

class ScheduledEventService: ScheduledEventServiceProtocol, ObservableObject {
    
    private var repository = FirestoreRepository<ScheduledEvent>(collection: "scheduledEvents")
            
    func getScheduledEvents(assembleQuery: @escaping (Query) -> Query) async -> [ScheduledEvent] {
        do {
            return try await repository.fetchData(assembleQuery: assembleQuery).get()
        } catch {
            return []
        }
    }
    
    func scheduleEvent(event: ScheduledEvent) async -> ScheduledEvent? {
        do {
            return try await repository.create(data: event).get()
        }
        catch {
            return nil
        }
    }
    
    func getScheduledEvent(id: String) async -> ScheduledEvent? {
        do {
            return try await repository.getById(id: id).get()
        }
        catch {
            return nil
        }
    }
    
    func updateScheduledEvent(id: String, update: ScheduledEvent) async -> ScheduledEvent? {
        do {
            return try await repository.update(id: id, data: update).get()
        }
        catch {
            return nil
        }
    }
    
    func deleteScheduledEvent(id: String) async -> Bool {
        do {
            return try await repository.delete(id: id).get()
        }
        catch {
            return false
        }
    }
}
