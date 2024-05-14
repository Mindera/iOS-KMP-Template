//
//  SettingsCoordinator.swift
//  iOSKMP
//
//  Created by Timea Varga on 25.04.2024.
//

import SwiftUI

final class SettingsCoordinator {
    
    // MARK: - Properties
    
    private let router = Router()
    private var libraryLicensesCoordinator: LibraryLicensesCoordinator?
    
    // MARK: - Internal
    
    func popToRoot() {
        router.popToRoot()
    }
    
    // MARK: - Private
    
    private func makeSettingsView() -> AnyView {
        let viewModel = SettingsViewModel(delegate: self)
        let view = SettingsView(viewModel: viewModel, router: router)
        
        return view.eraseToAnyView()
    }
    
    private func goToRepository() {
        guard let url = URL(string: Constants.repositoryURLString) else { return }
        UIApplication.shared.open(url)
    }
    
    private func presentLibraryLicences() {
        libraryLicensesCoordinator = LibraryLicensesCoordinator(router: router)
        libraryLicensesCoordinator?.start()
    }
}

// MARK: - RootCoordinator

extension SettingsCoordinator: RootCoordinator {
    func start() -> AnyView {
        makeSettingsView()
    }
}

// MARK: - SettingsCoordinatorDelegate

extension SettingsCoordinator: SettingsCoordinatorDelegate {
    func didSelectRepository() {
        goToRepository()
    }
    
    func didSelectLibraryLicenses() {
        presentLibraryLicences()
    }
}
