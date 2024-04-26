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
    
    private var settingsCoordinator: SettingsCoordinator?
    
    func start() -> AnyView {
        makeMenuTabView()
    }
    
    private func makeMenuTabView() -> AnyView {
        let tabs = [makeHomeRootTab(), makeSettingsRootTab()]
        let viewModel = MenuTabViewModel(selectedTab: .home, tabs: tabs, delegate: self)
        let view = MenuTabView(viewModel: viewModel)
            .environment(\.colorScheme, isDarkMode ? .dark : .light)
            .preferredColorScheme(isDarkMode ? .dark : .light)
            .environment(\.locale, Locale(identifier: selectedLanguageIdentifier))
        
        return AnyView(view)
    }
    
    private func makeHomeRootTab() -> MenuTabElement {
        let homeView = HomeCoordinator().start()
        return makeMenuTabElement(view: homeView, type: .home)
    }
    
    private func makeSettingsRootTab() -> MenuTabElement {
        let settingsCoordinator = SettingsCoordinator()
        let settingsView = settingsCoordinator.start()
        self.settingsCoordinator = settingsCoordinator
        return makeMenuTabElement(view: settingsView, type: .settings)
    }
    
    private func itemMenuTabElement(type: MenuTabType) -> AnyView {
        switch type {
        case .home:
            return AnyView(Label(MenuTabType.home.title, systemImage: MenuTabType.home.imageName))
        case .settings:
            return AnyView(Label(MenuTabType.settings.title, systemImage: MenuTabType.settings.imageName))
        }
    }
    
    private func makeMenuTabElement(view: AnyView, type: MenuTabType) -> MenuTabElement {
        MenuTabElement(type: type, view: view, item: AnyView(itemMenuTabElement(type: type)))
    }
}

// MARK: - TabBarCoordinatorDelegate

extension TabBarCoordinator: TabBarCoordinatorDelegate {
    func didChangeSelectedTab(_ tab: MenuTabType) {
//        switch tab {
//        case .home:
//            
//        case .settings:
//        }
    }
}
