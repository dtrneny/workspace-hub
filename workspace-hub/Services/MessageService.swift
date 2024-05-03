//
//  MessageService.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 02.05.2024.
//

import Foundation
import FirebaseFirestore

protocol MessageServiceProtocol {
    func getGroupMessages(
        assembleQuery: @escaping (Query) -> Query,
        completion: @escaping ([Message], Error?
    ) -> Void)
    func createMessage(message: Message) async -> Message?
}

class MessageService: MessageServiceProtocol, ObservableObject {

    private var repository = FirestoreRepository<Message>(collection: "messages")
    
    func getGroupMessages(
        assembleQuery: @escaping (Query) -> Query,
        completion: @escaping ([Message], Error?) -> Void
    ) {
        repository.listenToCollection(assembleQuery: assembleQuery, completion: completion)
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
