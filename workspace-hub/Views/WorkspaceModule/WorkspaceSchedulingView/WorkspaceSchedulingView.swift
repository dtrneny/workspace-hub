//
//  WorkspaceSchedulingView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 06.05.2024.
//

import SwiftUI

struct WorkspaceSchedulingView: View {
    
    let workspaceId: String
    
    @EnvironmentObject var coordinator: WorkspaceCoordinator
    
    @StateObject private var viewModel = WorkspaceSchedulingViewModel(
        scheduledEventService: ScheduledEventService(),
        workspaceService: WorkspaceService(),
        groupService: GroupService(),
        accountService: AccountService()
    )
    
    var body: some View {
        BaseLayout {
            switch viewModel.state {
            case .loading:
                LoadingDots(type: .view)
            default:
                ViewTitle(title: "Schedule event")
                        
                ScrollView {
                    formView
                    
                    scheduleButton
                }
            }
        }
        .routerBarBackArrowHidden(viewModel.schedulingEvent || viewModel.state == ViewState.loading)
        .onAppear {
            Task {
                await viewModel.fetchInitialData(workspaceId: workspaceId)
            }
        }
        .onChange(of: viewModel.selectedGroupId) { oldValue, newValue in
            Task {
                await viewModel.getGroupAccounts()
            }
        }
    }
}

extension WorkspaceSchedulingView {
    
    private var formView: some View {
        VStack(spacing: 38) {
            VStack(alignment: .leading) {
                Text("Base infromation")
                    .foregroundStyle(.secondary900)
                    .font(.inter(18.0))
                    .fontWeight(.medium)
                    .padding([.bottom], 5)
                
                Divider()
                    .padding([.bottom], 10)
                
                VStack(spacing: 19) {
                    FormField {
                        TextInput(
                            value: $viewModel.eventTitle,
                            placeholder: "Event title",
                            label: "Event title"
                        )
                        if let error = viewModel.eventTitleError {
                            ErrorMessage(error: error)
                        }
                    }
                    
                    FormField {
                        TextArea(value: $viewModel.eventDescription, label: "Event description")
                            .preferredColorScheme(.light)

                        if let error = viewModel.eventTitleError {
                            ErrorMessage(error: error)
                        }
                    }
                    
                    HStack() {
                        Text("Event start")
                            .foregroundStyle(.secondary900)
                            .font(.inter(16.0))
                        
                        Spacer()
                        
                        DatePicker(selection: $viewModel.startAt, displayedComponents: [.date, .hourAndMinute]) {}
                            .datePickerStyle(.compact)
                            .onTapGesture(count: 99, perform: {
                                // overrides tap gesture to fix ios 17.1 bug
                            })
                    }
                    
                    FormField {
                        HStack() {
                            Text("Event end")
                                .foregroundStyle(.secondary900)
                                .font(.inter(16.0))
                            
                            Spacer()
                            
                            DatePicker(selection: $viewModel.endAt, displayedComponents: [.date, .hourAndMinute]) {}
                                .datePickerStyle(.compact)
                                .onTapGesture(count: 99, perform: {
                                    // overrides tap gesture to fix ios 17.1 bug
                                })
                        }

                        if let error = viewModel.endAtError {
                            ErrorMessage(error: error)
                        }
                    }
                    
                }
            }
            
            VStack(alignment: .leading) {
                Text("Group and members")
                    .foregroundStyle(.secondary900)
                    .font(.inter(18.0))
                    .fontWeight(.medium)
                    .padding([.bottom], 5)
                
                Divider()
                    .padding([.bottom], 10)
                
                VStack(spacing: 19) {
                    FormField {
                        HStack() {
                            Text("Group")
                                .foregroundStyle(.secondary900)
                                .font(.inter(16.0))
                            
                            Spacer()
                            
                            Picker("Pick a group", selection: $viewModel.selectedGroupId) {
                                Text("None")
                                    .tag(nil as String?)
                                
                                ForEach(viewModel.groups, id: \.id) {
                                    Text($0.name)
                                        .tag($0.id)
                                }
                            }
                            .accentColor(.secondary900)
                        }
                        
                        if let error = viewModel.groupError {
                            ErrorMessage(error: error)
                        }
                    }
                    
                    if(!viewModel.presentedAccounts.isEmpty) {
                        FormField {
                            ScrollView {
                                ForEach(viewModel.presentedAccounts) { account in
                                    HStack {
                                        HStack (spacing: 10) {
                                            if let cachedImage = ImageCache.shared.getImage(urlString: account.profileImage) {
                                                Image(uiImage: cachedImage)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 40, height: 40)
                                                    .clipShape(Circle())
                                            } else {
                                                Circle()
                                                    .foregroundColor(.secondary900)
                                                    .frame(width: 40, height: 40)
                                                    .overlay(
                                                        Image("logo")
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: 20, height: 20)
                                                    )
                                            }
                                            
                                            
                                            Text("\(account.firstname) \(account.lastname)")
                                        }
                                        
                                        Spacer()
                                        
                                        Checkbox(action: { value in
                                            if let id = account.id {
                                                if (value) {
                                                    viewModel.fillterOutAccountId(accountId: id)
                                                } else {
                                                    viewModel.appendAccountId(accountId: id)
                                                }
                                            }
                                        }, initialState: false)
                                        .padding([.trailing], 10)
                                    }
                                }
                            }
                            if let error = viewModel.selectedAccountError {
                                ErrorMessage(error: error)
                            }
                        }
                    }
                }
            }
        }
        .padding([.bottom], 38)
       
    }
    
    private var scheduleButton: some View {
        BaseButton {
            HStack (spacing: 8) {
                if (viewModel.schedulingEvent) {
                    ProgressView()
                        .tint(.white)
                }
                Text("Schedule event")
                    .font(.inter(16.0))
            }
        }
        .onTapGesture {
            Task {
                if(await viewModel.scheduleEvent(workspaceId: workspaceId)) {
                    coordinator.pop()
                }
            }
        }
    }
    
}
