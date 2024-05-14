//
//  HomeCoordinator.swift
//  iOSKMP
//
//  Created by Timea Varga on 26.04.2024.
//

import SwiftUI
import SwiftData

final class HomeCoordinator: RootCoordinator {
    
    // MARK: - Properties
    
    private let modelContext: ModelContext
    private var viewModel: CurrencyExchangeViewModel?
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // MARK: - Internal
    
    func start() -> AnyView {
        makeHomeView()
    }
    
    func popToRoot() {
        viewModel?.selectedViewMode = .graph
    }
    
    // MARK: - Private
    
    private func makeHomeView() -> AnyView {
        let viewModel = CurrencyExchangeViewModel(modelContext: modelContext, selectedViewMode: .graph)
        let view = CurrencyExchangeView(viewModel: viewModel)
        self.viewModel = viewModel
        
        return view.eraseToAnyView()
    }
}
