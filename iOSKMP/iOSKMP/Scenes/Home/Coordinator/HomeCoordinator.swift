//
//  HomeCoordinator.swift
//  iOSKMP
//
//  Created by Timea Varga on 26.04.2024.
//

import SwiftUI

final class HomeCoordinator: RootCoordinator {
    func start() -> AnyView {
        makeHomeView()
    }
    
    private func makeHomeView() -> AnyView {
        let viewModel = CurrencyExchangeViewModel(selectedViewMode: .graph)
        let view = CurrencyExchangeView(viewModel: viewModel)
        
        return AnyView(view)
    }
}
