//
//  SettingsCoordinator.swift
//  iOSKMP
//
//  Created by Timea Varga on 25.04.2024.
//

import SwiftUI

final class SettingsCoordinator {
    private let router = Router()
    private var libraryLicensesCoordinator: LibraryLicensesCoordinator?
    
    func popToRoot() {
        router.popToRoot()
    }
    
    private func makeSettingsView() -> AnyView {
        let viewModel = SettingsViewModel(delegate: self)
        let view = SettingsView(viewModel: viewModel, router: router)
        
        return AnyView(view)
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

extension SettingsCoordinator: RootCoordinator {
    func start() -> AnyView {
        makeSettingsView()
    }
}

extension SettingsCoordinator: SettingsCoordinatorDelegate {
    func didSelectRepository() {
        goToRepository()
    }
    
    func didSelectLibraryLicenses() {
        presentLibraryLicences()
    }
}
