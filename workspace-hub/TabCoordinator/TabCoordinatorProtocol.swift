//
//  TabCoordinatorProtocol.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import Foundation

protocol TabCoordinatorProtocol: ObservableObject  {
    associatedtype TabSection: Hashable
    
    var history: [TabSection] { get set }
    
    func changeSection(to section: TabSection)
    func pop()
    func replaceAll(with sections: [TabSection])
}
