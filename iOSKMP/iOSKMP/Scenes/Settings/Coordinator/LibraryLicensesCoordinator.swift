//
//  LibraryLicensesCoordinator.swift
//  iOSKMP
//
//  Created by Timea Varga on 26.04.2024.
//

import SwiftUI

final class LibraryLicensesCoordinator: Coordinator {
    private let router: Routable
    
    init(router: Routable) {
        self.router = router
    }
    
    func start() {
        let viewModel = LibraryLicencesViewModel(delegate: self)
        let view = NavigableView(view: AnyView(LibraryLicencesView(viewModel: viewModel)))
        router.present(view)
    }
}

extension LibraryLicensesCoordinator: LibraryLicencesCoordinatorDelegate {
    func didSelectBack() {
        router.pop()
    }
}
