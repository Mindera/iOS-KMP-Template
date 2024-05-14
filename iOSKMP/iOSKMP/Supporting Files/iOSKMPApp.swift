//
//  iOSKMPApp.swift
//  iOSKMP
//
//  Created by Naveen Katari  on 18/03/24.
//

import SwiftUI
import SwiftData
import CurrencyExchangeKMP

@main
struct iOSKMPApp: App {
    
    // MARK: - Properties
    
    private let modelContainer: ModelContainer
    private let tabBarCoordinator: RootCoordinator
    
    var body: some Scene {
        WindowGroup {
            tabBarCoordinator.start()
        }
        .modelContainer(modelContainer)
    }
    
    // MARK: - Init
    
    init() {
        do {
            modelContainer = try ModelContainer(for: CurrencyExchangeModel.self, CurrencyExchangeRateModel.self)
        } catch {
            fatalError("Failed to create ModelContainer for CurrencyExchangeModel and/or CurrencyExchangeRateModel.")
        }
        
        tabBarCoordinator = TabBarCoordinator(modelContext: modelContainer.mainContext)
        IOSKoinHelperKt.doInitKoin()
        setupLocaleValue()
        Bundle.swizzleLocalization()
    }
    
    // MARK: - Private
    
    private func setupLocaleValue() {
        if UserDefaults.standard.value(forKey: Constants.localeKey) == nil {
            UserDefaults.standard.setValue(LanguageType.english.identifier, forKey: Constants.localeKey)
        }
    }
}
