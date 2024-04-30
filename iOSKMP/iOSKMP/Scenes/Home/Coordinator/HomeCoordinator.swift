//
//  HomeCoordinator.swift
//  iOSKMP
//
//  Created by Timea Varga on 26.04.2024.
//

import SwiftUI

@Observable final class HomeCoordinator: RootCoordinator {
    
    // MARK: - Properties
    
    private var viewModel: CurrencyExchangeViewModel?
    
    // MARK: - Internal methods
    
    func start() -> AnyView {
        makeHomeView()
    }
    
    func popToRoot() {
        viewModel?.selectedViewMode = .graph
    }
    
    // MARK: - Private methods
    
    private func makeHomeView() -> AnyView {
        let viewModel = CurrencyExchangeViewModel(selectedViewMode: .graph)
        let view = CurrencyExchangeView(viewModel: viewModel)
        self.viewModel = viewModel
        
        return AnyView(view)
    }
}
