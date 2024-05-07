//
//  ScheduledEventRow.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 07.05.2024.
//

import SwiftUI

struct ScheduledEventRow: View {
    
    var event: ScheduledEvent
    
    var body: some View {
        VStack (alignment: .leading, spacing: 8) {
            
            VStack(alignment: .leading, spacing: 5) {
                if (checkIfSameDate()) {
                    Text(DateUtil.formatTimespan(from: event.startAt, to: event.endAt))
                        .foregroundColor(.grey300)
                        .font(.inter(12.0))
                        .fontWeight(.regular)
                } else {
                    Text("\(DateUtil.formatFullDate(date: event.startAt)) - \(DateUtil.formatFullDate(date: event.endAt))")
                        .foregroundColor(.grey300)
                        .font(.inter(12.0))
                        .fontWeight(.regular)
                }
                
                Text(event.title)
                    .foregroundColor(.white)
                    .font(.inter(16.0))
                    .fontWeight(.semibold)
                    .padding([.bottom], 5)
                
                if let description = event.description {
                    Text(description)
                        .foregroundColor(.grey300)
                        .font(.inter(14.0))
                        .fontWeight(.regular)
                        .lineLimit(2)
                }
            }
            .padding([.bottom], 15)
            
            users
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.secondary900)
        .cornerRadius(18)
    }
                        
    func checkIfSameDate() -> Bool {
        return event.startAt.day == event.endAt.day && event.startAt.month == event.endAt.month
    }
}

extension ScheduledEventRow {
    
    private var users: some View {
        ZStack {
            ForEach(event.userImageUrls.indices, id: \.self) { index in
                let url = event.userImageUrls[index]
                
                VStack {
                    if (index < 3) {
                        if let cachedImage = ImageCache.shared.getImage(urlString: url) {
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
                    }
                }
                .offset(x: CGFloat(index) * 20)
                .zIndex(Double(index))
            }
        }
    }
}
