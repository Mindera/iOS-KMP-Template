//
//  TabBarCoordinator.swift
//  iOSKMP
//
//  Created by Timea Varga on 25.04.2024.
//

import SwiftUI

final class TabBarCoordinator: RootCoordinator {
    
    // MARK: - Properties
    
    private var homeCoordinator: HomeCoordinator?
    private var settingsCoordinator: SettingsCoordinator?
    
    // MARK: - Internal methods
    
    func start() -> AnyView {
        makeMenuTabView()
    }
    
    // MARK: - Private methods
    
    private func makeMenuTabView() -> AnyView {
        let tabs = [makeHomeRootTab(), makeSettingsRootTab()]
        let viewModel = MenuTabViewModel(selectedTab: .home, tabs: tabs, delegate: self)
        let view = MenuTabView(viewModel: viewModel)

        return view.eraseToAnyView()
    }
    
    private func makeHomeRootTab() -> MenuTabElement {
        let homeCoordinator = HomeCoordinator()
        let homeView = homeCoordinator.start()
        self.homeCoordinator = homeCoordinator
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
            return Label(MenuTabType.home.title, systemImage: MenuTabType.home.imageName).eraseToAnyView()
        case .settings:
            return Label(MenuTabType.settings.title, systemImage: MenuTabType.settings.imageName).eraseToAnyView()
        }
    }
    
    private func makeMenuTabElement(view: AnyView, type: MenuTabType) -> MenuTabElement {
        MenuTabElement(type: type, view: view, item: itemMenuTabElement(type: type))
    }
}

// MARK: - TabBarCoordinatorDelegate

extension TabBarCoordinator: TabBarCoordinatorDelegate {
    func didChangeSelectedTab(_ tab: MenuTabType) {
        switch tab {
        case .home:
            homeCoordinator?.popToRoot()
        case .settings:
            settingsCoordinator?.popToRoot()
        }
    }
}
