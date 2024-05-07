//
//  TimelineRootView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.04.2024.
//

import SwiftUI

struct TimelineView: View {
    
    @EnvironmentObject var coordinator: TimelineCoordinator
    
    @StateObject private var viewModel = TimelineViewModel(
        scheduledEventService: ScheduledEventService()
    )

    var body: some View {
        BaseLayout {
            switch viewModel.state {
            case .loading:
                LoadingDots(type: .view)
            default:
                HStack(alignment: .firstTextBaseline) {
                    DynamicViewTitle(title: DateUtil.monthName(from: viewModel.selectedMonth))
                    
                    Spacer()
                    
                    HStack (spacing: 10) {
                        OperationButton(icon: "chevron.left") {
                            viewModel.previousMonth()
                        }
                        
                        OperationButton(icon: "chevron.right") {
                            viewModel.nextMonth()
                        }
                        
                        OperationButton(icon: "arrow.counterclockwise") {
                            viewModel.resetTimeline()
                        }
                    }
                }
                
                DateSwiper(
                    dates: DateUtil.generateMonthDates(for: viewModel.selectedMonth),
                    selectedDate: $viewModel.selectedDate,
                    selectedMonth: $viewModel.selectedMonth
                )
                .padding([.bottom], 19)
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 10) {
                        Text("Planned")
                            .foregroundStyle(.secondary900)
                            .font(.inter(18.0))
                            .fontWeight(.medium)
                            .opacity(viewModel.presentedFromOthers ? 0.5 : 1)
                            .onTapGesture {
                                viewModel.presentedFromOthers = false
                            }
                        
                        Text("/")
                            .foregroundStyle(.secondary900)
                            .font(.inter(18.0))
                            .fontWeight(.medium)
                        
                        Text("Planned from others")
                            .foregroundStyle(.secondary900)
                            .font(.inter(18.0))
                            .fontWeight(.medium)
                            .opacity(viewModel.presentedFromOthers ? 1 : 0.5)
                            .onTapGesture {
                                viewModel.presentedFromOthers = true
                            }
                    }
                    .padding([.bottom], 5)

                    if (!viewModel.presentedFromOthers) {
                        plannedByUser
                    } else {
                        plannedFromOthers
                    }
                    
                }
            }
        }
        .routerBarBackArrowHidden(viewModel.state == ViewState.loading)
        .onAppear {
            Task {
                await viewModel.fetchInitialData()
            }
        }
    }
}

extension TimelineView {
    
    private var plannedByUser: some View {
        VStack(alignment: .leading) {

            ScrollView {
                ForEach(viewModel.plannedByUserPresented, id: \.id) { event in
                    ScheduledEventRow(event: event)
                }
            }
        }
    }
    
    private var plannedFromOthers: some View {
        VStack(alignment: .leading) {

//            ScrollView {
//                ForEach(viewModel.invitationAccounts, id: \.id) { invAccount in
//                    CommonAccountListRow(
//                        name: "\(invAccount.account.firstname) \(invAccount.account.lastname)",
//                        email: invAccount.account.email,
//                        imageUrl: invAccount.account.profileImage
//                    ) {
//                        OperationButton(icon: "location.slash.fill", color: .primaryRed700) {
//                            viewModel.deletedInvitation = invAccount.invitationId
//                            viewModel.deleteInvitationConfirmation = true
//                        }
//                    }
//                }
//            }
        }
    }
    
}
