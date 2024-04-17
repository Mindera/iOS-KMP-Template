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
    init() {
        IOSKoinHelperKt.doInitKoin()
    }

    var body: some Scene {
        WindowGroup {
            MenuTabView()
        }
    }
}
