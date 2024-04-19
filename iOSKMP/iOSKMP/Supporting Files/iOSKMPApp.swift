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
    
    init() {
        IOSKoinHelperKt.doInitKoin()
    }

    var body: some Scene {
        WindowGroup {
            MenuTabView()
                .environment(\.colorScheme, isDarkMode ? .dark : .light)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
