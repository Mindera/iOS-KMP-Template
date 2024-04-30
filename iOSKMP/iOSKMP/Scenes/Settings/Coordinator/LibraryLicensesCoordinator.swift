//
//  LibraryLicensesCoordinator.swift
//  iOSKMP
//
//  Created by Timea Varga on 26.04.2024.
//

import SwiftUI

final class LibraryLicensesCoordinator: Coordinator {
    
    // MARK: - Properties
    
    private let router: Routable
    
    // MARK: - Init
    
    init(router: Routable) {
        self.router = router
    }
    
    // MARK: - Internal methods
    
    func start() {
        let viewModel = LibraryLicencesViewModel(delegate: self)
        let view = NavigableView(view: AnyView(LibraryLicencesView(viewModel: viewModel)))
        router.present(view)
    }
}

// MARK: - LibraryLicencesCoordinatorDelegate

extension LibraryLicensesCoordinator: LibraryLicencesCoordinatorDelegate {
    func didSelectBack() {
        router.pop()
    }
}
