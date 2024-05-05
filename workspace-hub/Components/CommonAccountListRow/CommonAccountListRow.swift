//
//  CommonAccountListRow.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 04.05.2024.
//

import SwiftUI

struct CommonAccountListRow<Content: View>: View {
    
    var name: String
    var email: String
    var imageUrl: String
    
    let content: Content
        
    init(name: String, email: String, imageUrl: String, @ViewBuilder content: () -> Content) {
        self.name = name
        self.email = email
        self.imageUrl = imageUrl
        self.content = content()
    }
    
    var body: some View {
        HStack (alignment: .center, spacing: 10) {
            
            if let cachedImage = ImageCache.shared.getImage(urlString: imageUrl) {
                Image(uiImage: cachedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
            } else {
                Circle()
                    .foregroundColor(.secondary900)
                    .frame(width: 45, height: 45)
                    .overlay(
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                    )
            }
            
            VStack (alignment: .leading) {
                Text(name)
                    .foregroundColor(.white)
                    .font(.inter(16.0))
                    .fontWeight(.semibold)
                Text(email)
                    .foregroundColor(.grey300)
                    .font(.inter(14.0))
                    .fontWeight(.regular)
            }
            
            Spacer()
            
            content
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.secondary900)
        .cornerRadius(15)
    }
}

#Preview {
    VStack {
        CommonAccountListRow(name: "John Doe", email: "john.doe@testing.com", imageUrl: "https://cataas.com/cat") {
            HStack {
                OperationButton(icon: "heart.fill") {
                    print("test")
                }
            }
        }
    }
    .padding()
}
