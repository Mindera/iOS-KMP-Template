//
//  HomeCoordinator.swift
//  iOSKMP
//
//  Created by Timea Varga on 26.04.2024.
//

import SwiftUI

final class HomeCoordinator: RootCoordinator {
    
    // MARK: - Properties
    
    private var viewModel: CurrencyExchangeViewModel?
    
    // MARK: - Internal
    
    func start() -> AnyView {
        makeHomeView()
    }
    
    func popToRoot() {
        viewModel?.selectedViewMode = .graph
    }
    
    // MARK: - Private
    
    private func makeHomeView() -> AnyView {
        let viewModel = CurrencyExchangeViewModel(selectedViewMode: .graph)
        let view = CurrencyExchangeView(viewModel: viewModel)
        self.viewModel = viewModel
        
        return view.eraseToAnyView()
    }
}
