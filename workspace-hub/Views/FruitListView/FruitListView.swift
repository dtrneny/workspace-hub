//
//  FruitListView.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 15.03.2024.
//

import SwiftUI

struct FruitListView: View {
    
    @StateObject private var viewModel = FruitListViewModel(fruitRepository: FruitRepository())
    
    var body: some View {
        VStack {
            Section {
                HStack {
                    TextInput(value: $viewModel.name, placeholder: "testing", label: "Test")
                    Button("Submit") {
                        viewModel.addFruit(fruit: Fruit(name: viewModel.name))
                        viewModel.name = ""
                    }
                }.padding(16)
            }
            Divider()
            List(viewModel.fruits, id: \.id) { fruit in
                Text(fruit.name)
            }
            .onAppear { viewModel.fetchFruits() }
            
        }
    }
}

#Preview {
    FruitListView()
}
