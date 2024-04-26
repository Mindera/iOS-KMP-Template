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
        let view = NavigableView(view: AnyView(LibraryLicencesView()))
        router.present(view)
    }
}
