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
    // MARK: - Properties
    
    private let tabBarCoordinator: RootCoordinator
    
    var body: some Scene {
        WindowGroup {
            tabBarCoordinator.start()
        }
    }
    
    // MARK: - Init
    
    init() {
        tabBarCoordinator = TabBarCoordinator()
        IOSKoinHelperKt.doInitKoin()
        setupLocaleValue()
        Bundle.swizzleLocalization()
    }
    
    // MARK: - Private methods
    
    private func setupLocaleValue() {
        if UserDefaults.standard.value(forKey: Constants.localeKey) == nil {
            UserDefaults.standard.setValue(LanguageType.english.identifier, forKey: Constants.localeKey)
        }
    }
}
