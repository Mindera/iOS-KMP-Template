//
//  iOSKMPApp.swift
//  iOSKMP
//
//  Created by Naveen Katari  on 18/03/24.
//

import SwiftUI
import CurrencyExchangeKMP

@main
struct iOSKMPApp: App {
    private let tabBarCoordinator: RootCoordinator
    
    init() {
        tabBarCoordinator = TabBarCoordinator()
        IOSKoinHelperKt.doInitKoin()
    }

    var body: some Scene {
        WindowGroup {
            tabBarCoordinator.start()
        }
    }
}
