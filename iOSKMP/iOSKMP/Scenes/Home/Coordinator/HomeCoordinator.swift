//
//  HomeCoordinator.swift
//  iOSKMP
//
//  Created by Timea Varga on 26.04.2024.
//

import SwiftUI

@Observable final class HomeCoordinator: RootCoordinator {
    private var viewModel: CurrencyExchangeViewModel?
    
    func start() -> AnyView {
        makeHomeView()
    }
    
    func popToRoot() {
        viewModel?.selectedViewMode = .graph
    }
    
    private func makeHomeView() -> AnyView {
        let viewModel = CurrencyExchangeViewModel(selectedViewMode: .graph)
        let view = CurrencyExchangeView(viewModel: viewModel)
        self.viewModel = viewModel
        
        return AnyView(view)
    }
}
