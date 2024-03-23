//
//  ViewModel.swift
//  workspace-hub
//
//  Created by Dalibor Trněný on 17.03.2024.
//

import Foundation

protocol ViewModelProtocol: ObservableObject {
    associatedtype State
    var state: State { get set }
}
