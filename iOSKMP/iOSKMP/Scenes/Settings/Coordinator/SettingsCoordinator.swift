//
//  SettingsCoordinator.swift
//  iOSKMP
//
//  Created by Timea Varga on 25.04.2024.
//

import SwiftUI

final class SettingsCoordinator {
    private let router = Router()
    
    private func makeSettingsView() -> AnyView {
        let viewModel = SettingsViewModel(delegate: self)
        let view = SettingsView(viewModel: viewModel, router: router)
        
        return AnyView(view)
    }
    
    private func presentLibraryLicences() {
        let coordinator = LibraryLicensesCoordinator(router: router)
        coordinator.start()
    }
}

extension SettingsCoordinator: RootCoordinator {
    func start() -> AnyView {
        makeSettingsView()
    }
}

extension SettingsCoordinator: SettingsCoordinatorDelegate {
    func didSelectLibraryLicenses() {
        presentLibraryLicences()
    }
}
