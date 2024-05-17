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
    
    private let modelContainer: ModelContainer
    private var viewModel: CurrencyExchangeViewModel?
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
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
        let viewModel = CurrencyExchangeViewModel(modelContainer: modelContainer, selectedViewMode: .graph)
        let view = CurrencyExchangeView(viewModel: viewModel)
        self.viewModel = viewModel
        
        return view.eraseToAnyView()
    }
}
