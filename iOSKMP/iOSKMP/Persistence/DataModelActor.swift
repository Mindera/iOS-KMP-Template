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
typealias ExchangeRateWithTimestamp = (exchangeRate: ExchangeRate, timestamp: Date)
typealias CurrencyExchangeWithTimestamp = (currencyExchange: CurrencyExchange, timestamp: Date)

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
    
    func addCurrencyExchangeRateItem(_ item: ExchangeRateWithTimestamp) {
        modelContext.insert(
            CurrencyExchangeRateModel(
                referenceId: item.exchangeRate.id,
                code: item.exchangeRate.code,
                currencyName: item.exchangeRate.currencyName,
                exchangeRate: item.exchangeRate.exchangeRate,
                timestamp: item.timestamp
            )
        )
        
        saveDataIfNeeded()
    }
    
    func addCurrencyExchangeItem(_ item: CurrencyExchangeWithTimestamp) {
        modelContext.insert(
            CurrencyExchangeModel(
                referenceId: item.currencyExchange.id,
                date: item.currencyExchange.date,
                exchangeRates: item.currencyExchange.exchangeRates,
                timestamp: item.timestamp
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
    
    func fetchCurrencyExchangeData() throws -> (currencyExchangeRates: [ExchangeRate], currencyExchangeModels: [CurrencyExchange]) {
        let currencyExchangeRates = try fetchCurrencyExchangeRates()
        let currencyExchangeModels = try fetchCurrencyExchangeModels()
        
        return (currencyExchangeRates, currencyExchangeModels)
    }
    
    func fetchCurrencyExchangeRates() throws -> [ExchangeRate] {
        var currencyExchangeRates: [ExchangeRate] = []
        
        let descriptor = FetchDescriptor<CurrencyExchangeRateModel>(sortBy: [SortDescriptor(\.timestamp)])
        currencyExchangeRates = try modelContext.fetch(descriptor).map { ($0.referenceId, $0.code, $0.currencyName, $0.exchangeRate) }
        
        return currencyExchangeRates
    }
    
    func fetchCurrencyExchangeModels() throws -> [CurrencyExchange] {
        var currencyExchangeModels: [CurrencyExchange] = []
        
        let descriptor = FetchDescriptor<CurrencyExchangeModel>(sortBy: [SortDescriptor(\.timestamp)])
        currencyExchangeModels = try modelContext.fetch(descriptor).map { ($0.referenceId, $0.date, $0.exchangeRates) }

        return currencyExchangeModels
    }
    
    // MARK: - Private
    
    private func saveDataIfNeeded() {
        guard modelContext.hasChanges else { return }
        
        do {
            try modelContext.save()
        }
        catch {
            // TODO: Handle error
        }
    }
}

