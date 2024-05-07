//
//  TimelineEventDetail.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 07.05.2024.
//

import SwiftUI

struct TimelineEventDetailView: View {
    
    let eventId: String
    
    @EnvironmentObject var coordinator: TimelineCoordinator
    
    @StateObject private var viewModel = TimelineEventDetailViewModel(
        scheduledEventService: ScheduledEventService(),
        accountService: AccountService(),
        groupService: GroupService()
    )
    
    var body: some View {
        BaseLayout {
            switch viewModel.state {
            case .loading:
                LoadingDots(type: .view)
            default:
                VStack(alignment: .leading) {
                    if let event = viewModel.event, let group = viewModel.group {
                        HStack (alignment: .firstTextBaseline) {
                            DynamicViewTitle(title: event.title)
                            
                            Spacer()
                            
                            if (viewModel.isUserScheduler) {
                                OperationButton(icon: "trash.fill", color: .primaryRed700) {
                                    viewModel.deleteEventConfirmation = true
                                }
                            }
                        }
                                
                        ScrollView {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Start: \(DateUtil.formatFullDate(date: event.startAt))")
                                    .foregroundStyle(.secondary900)
                                    .font(.inter(16.0))
                                    .fontWeight(.medium)
                                
                                Text("End: \(DateUtil.formatFullDate(date: event.endAt))")
                                    .foregroundStyle(.secondary900)
                                    .font(.inter(16.0))
                                    .fontWeight(.medium)
                                
                                if let description = event.description {
                                    Text(description)
                                        .foregroundStyle(.secondary900)
                                        .font(.inter(16.0))
                                        .fontWeight(.regular)
                                        .padding([.bottom], 19)
                                }
                            }
                            
                            VStack (alignment: .leading, spacing: 38) {
                                VStack(alignment: .leading) {
                                    Text("Group")
                                        .foregroundStyle(.secondary900)
                                        .font(.inter(18.0))
                                        .fontWeight(.medium)
                                        .padding([.bottom], 10)
                                    
                                    CommonGroupListRow(name: group.name, variableText: "", symbol: group.icon) {}
                                }
                                
                                VStack(alignment: .leading) {
                                    Text("Group and members")
                                        .foregroundStyle(.secondary900)
                                        .font(.inter(18.0))
                                        .fontWeight(.medium)
                                        .padding([.bottom], 10)
                                    
                                    ForEach(viewModel.accounts) { account in
                                        CommonAccountListRow(name: "\(account.firstname) \(account.lastname)", email: account.email, imageUrl: account.profileImage) {}
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
        }
        .confirmationDialog(
            "Do you want to remove this event?",
            isPresented: $viewModel.deleteEventConfirmation,
            titleVisibility: .visible
        ) {
            Button("Confirm", role: .destructive) {
                Task {
                    if (await viewModel.deleteEvent(eventId: eventId)) {
                        coordinator.pop()
                    }
                }
            }
        }
        .routerBarBackArrowHidden(viewModel.state == ViewState.loading)
        .onAppear {
            Task {
                await viewModel.fetchInitialData(eventId: eventId)
            }
        }
    }
}
