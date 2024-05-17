//
//  DataCoordinator.swift
//  iOSKMP
//
//  Created by timea.varga on 15.05.2024.
//

import Foundation
import SwiftData

typealias ExchangeRate = (id: String, code: String, currencyName: String, exchangeRate: Double)
typealias CurrencyExchange = (id: String, date: String, exchangeRates: [CurrencyExchangeRate])

actor DataModelActor: ModelActor {
    
    // MARK: - Properties
    
    let modelContainer: ModelContainer
    let modelExecutor: any ModelExecutor
    
    // MARK: - Init
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
        let context = ModelContext(modelContainer)
        context.autosaveEnabled = true
        modelExecutor = DefaultSerialModelExecutor(modelContext: context)
    }
    
    // MARK: - Internal
    
    func addCurrencyExchangeRateItem(id: String, code: String, currencyName: String, exchangeRate: Double, timestamp: Date) {
        modelContext.insert(
            CurrencyExchangeRateModel(
                referenceId: id,
                code: code,
                currencyName: currencyName,
                exchangeRate: exchangeRate,
                timestamp: timestamp
            )
        )
        
        saveDataIfNeeded()
    }
    
    func addCurrencyExchangeItem(id: String, date: String, exchangeRates: [CurrencyExchangeRate], timestamp: Date) {
        modelContext.insert(
            CurrencyExchangeModel(
                referenceId: id,
                date: date,
                exchangeRates: exchangeRates,
                timestamp: timestamp
            )
        )
        
        saveDataIfNeeded()
    }
    
    func delete<T>(_ item: T.Type) where T : PersistentModel {
        do {
            try modelContext.delete(model: item)
        } catch {
            // TODO: Handle error
        }
    }
    
    func fetchCurrencyExchangeData() -> (currencyExchangeRates: [ExchangeRate], currencyExchangeModels: [CurrencyExchange]) {
        let currencyExchangeRates = fetchCurrencyExchangeRates()
        let currencyExchangeModels =  fetchCurrencyExchangeModels()
        
        return (currencyExchangeRates, currencyExchangeModels)
    }
    
    func fetchCurrencyExchangeRates() -> [ExchangeRate] {
        var currencyExchangeRates: [ExchangeRate] = []
        
        do {
            let descriptor = FetchDescriptor<CurrencyExchangeRateModel>(sortBy: [SortDescriptor(\.timestamp)])
            currencyExchangeRates = try modelContext.fetch(descriptor).map { ($0.referenceId, $0.code, $0.currencyName, $0.exchangeRate) }
        } catch {
            // TODO: Handle error
        }
        
        return currencyExchangeRates
    }
    
    func fetchCurrencyExchangeModels() -> [CurrencyExchange] {
        var currencyExchangeModels: [CurrencyExchange] = []
        
        do {
            let descriptor = FetchDescriptor<CurrencyExchangeModel>(sortBy: [SortDescriptor(\.timestamp)])
            currencyExchangeModels = try modelContext.fetch(descriptor).map { ($0.referenceId, $0.date, $0.exchangeRates) }
        } catch {
            // TODO: Handle error
        }
        
        return currencyExchangeModels
    }
    
    // MARK: - Private
    
    private func saveDataIfNeeded() {
        guard modelContext.hasChanges else { return }
        
        do {
            try modelContext.save()
        }
        catch {
            
        }
    }
}

