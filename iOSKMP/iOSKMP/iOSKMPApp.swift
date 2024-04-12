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
    init() {
        IOSKoinHelperKt.doInitKoin()
    }
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            CurrencyExchangeView()
        }
        .modelContainer(sharedModelContainer)
    }
}
