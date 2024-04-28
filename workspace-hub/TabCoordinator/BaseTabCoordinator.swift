//
//  TabCoordinator.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import Foundation

class BaseTabCoordinator<TabSections: Hashable>: ObservableObject, TabCoordinatorProtocol {
    
    typealias TabSection = TabSections
    
    @Published var history: [TabSections] = []
    
    func changeSection(to section: TabSections) {
        history.append(section)
    }
    
    func pop() {
        if (!history.isEmpty) {
            history.removeLast()
        }
    }
    
    func replaceAll(with sections: [TabSections]) {
        history = sections
    }
}
