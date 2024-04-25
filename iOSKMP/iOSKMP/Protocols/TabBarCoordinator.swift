//
//  TabBarCoordinator.swift
//  iOSKMP
//
//  Created by Timea Varga on 25.04.2024.
//

import SwiftUI

final class TabBarCoordinator: RootCoordinator {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("locale") private var selectedLanguageIdentifier = LanguageType.english.identifier
    
    func start() -> AnyView {
        makeMenuTabView()
    }
    
    private func makeMenuTabView() -> AnyView {
        let viewModel = MenuTabViewModel(selectedTab: .home, delegate: self)
        let view = MenuTabView(viewModel: viewModel)
            .environment(\.colorScheme, isDarkMode ? .dark : .light)
            .preferredColorScheme(isDarkMode ? .dark : .light)
            .environment(\.locale, Locale(identifier: selectedLanguageIdentifier))
        
        return AnyView(view)
    }
}

// MARK: - TabBarCoordinatorDelegate

extension TabBarCoordinator: TabBarCoordinatorDelegate {
    func didChangeSelectedTab(_ tab: MenuTab) {
        
    }
}
