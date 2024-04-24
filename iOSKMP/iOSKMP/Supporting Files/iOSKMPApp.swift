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
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("locale") private var selectedLanguageIdentifier = LanguageType.english.identifier
    
    init() {
        IOSKoinHelperKt.doInitKoin()
    }

    var body: some Scene {
        WindowGroup {
            MenuTabView()
                .environment(\.colorScheme, isDarkMode ? .dark : .light)
                .preferredColorScheme(isDarkMode ? .dark : .light)
                .environment(\.locale, Locale(identifier: selectedLanguageIdentifier))
        }
    }
}
