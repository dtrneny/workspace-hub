//
//  TimelineCoordinator.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import Foundation

enum TimelineTabSections: Hashable {
    case timeline
    case eventDetail(eventId: String)
}

class TimelineCoordinator: BaseTabCoordinator<TimelineTabSections> {
    override init() {
        super.init()
        self.changeSection(to: .timeline)
    }
}
