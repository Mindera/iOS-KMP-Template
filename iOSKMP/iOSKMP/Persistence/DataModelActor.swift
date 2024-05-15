//
//  DataCoordinator.swift
//  iOSKMP
//
//  Created by timea.varga on 15.05.2024.
//

import Foundation
import SwiftData

actor DataModelActor: ModelActor {
    // MARK: - Properties
    
    let modelContainer: ModelContainer
    let modelExecutor: any ModelExecutor
    
    // MARK: - Init
    
    init(container: ModelContainer) {
        modelContainer = container
        let context = ModelContext(container)
        modelExecutor = DefaultSerialModelExecutor(modelContext: context)
    }
    
    // MARK: - Internal
    
    func add<T>(_ item: T) where T : PersistentModel {
        modelContext.insert(item)
    }
    
    func delete<T>(_ item: T.Type) where T : PersistentModel {
        do {
            try modelContext.delete(model: item)
        } catch {
            // TODO: Handle error
        }
    }
    
    func fetchCurrencyExchangeData() -> (currencyExchangeRates: [CurrencyExchangeRateModel], currencyExchangeModels: [CurrencyExchangeModel]) {
        var currencyExchangeRates: [CurrencyExchangeRateModel] = []
        
        do {
            let descriptor = FetchDescriptor<CurrencyExchangeRateModel>(sortBy: [SortDescriptor(\.timestamp)])
            currencyExchangeRates = try modelContext.fetch(descriptor)
        } catch {
            // TODO: Handle error
        }
        
        var currencyExchangeModels: [CurrencyExchangeModel] = []
        
        do {
            let descriptor = FetchDescriptor<CurrencyExchangeModel>(sortBy: [SortDescriptor(\.timestamp)])
            currencyExchangeModels = try modelContext.fetch(descriptor)
        } catch {
            // TODO: Handle error
        }
        
        return (currencyExchangeRates, currencyExchangeModels)
    }
}
