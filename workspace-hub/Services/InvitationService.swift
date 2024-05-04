//
//  InvitationService.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 04.05.2024.
//

import Foundation
import FirebaseFirestore

protocol InvitationServiceProtocol {
    func getInvitations(assembleQuery: @escaping (Query) -> Query) async -> [Invitation]
    func createInvitation(invitation: Invitation) async -> Invitation?
}
    
class InvitationService: InvitationServiceProtocol, ObservableObject {
    
    private var repository = FirestoreRepository<Invitation>(collection: "invitations")
    
    func getInvitations(assembleQuery: @escaping (Query) -> Query) async -> [Invitation] {
        do {
            return try await repository.fetchData(assembleQuery: assembleQuery).get()
        } catch {
            return []
        }
    }
    
    func createInvitation(invitation: Invitation) async -> Invitation? {
        do {
            let newInvitation = try await repository.create(data: invitation).get()
            return newInvitation
        }
        catch {
            return nil
        }
    }
}
