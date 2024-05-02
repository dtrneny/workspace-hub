//
//  MessageService.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 02.05.2024.
//

import Foundation

protocol MessageServiceProtocol {
    func getActiveMessages(completion: @escaping ([Message], Error?) -> Void)
    func createMessage(message: Message) async -> Message?
}

class MessageService: MessageServiceProtocol, ObservableObject {

    private var repository = FirestoreRepository<Message>(collection: "messages")
    
    func getActiveMessages(completion: @escaping ([Message], Error?) -> Void) {
        repository.listenToCollection(completion: completion)
    }
    
    func createMessage(message: Message) async -> Message? {
        do {
            let newMessage = try await repository.create(data: message).get()
            return newMessage
        }
        catch {
            return nil
        }
    }
}
