//
//  SettingAccountCard.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 26.04.2024.
//

import SwiftUI

struct SettingAccountCard: View {
    
    var name: String
    var email: String
    var imageUrl: String
    
    var body: some View {
        HStack (alignment: .center, spacing: 19) {
            AsyncImage(url: URL(string: imageUrl), content: { image in
                image.image?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            })
            
            VStack (alignment: .leading, spacing: 5) {
                Text(name)
                    .foregroundColor(.white)
                    .font(.inter(18.0))
                    .fontWeight(.semibold)
                Text(email)
                    .foregroundColor(.grey300)
                    .font(.inter(16.0))
                    .fontWeight(.regular)
            }
            
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.secondary900)
        .cornerRadius(20)
    }
}

#Preview {
    VStack {
        SettingAccountCard(name: "John Doe", email: "john.doe@testing.com", imageUrl: "https://cataas.com/cat")
    }
    .padding()
}
