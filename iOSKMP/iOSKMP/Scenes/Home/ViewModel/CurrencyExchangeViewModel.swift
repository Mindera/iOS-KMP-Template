//
//  ExchangeRatesViewModel.swift
//  iOSKMP
//
//  Created by Naveen Katari  on 18/03/24.
//

import SwiftData
import CurrencyExchangeKMP

@Observable final class CurrencyExchangeViewModel {
    
    // MARK: - Properties
    
    var selectedViewMode: CurrencyExchangeViewMode
    var lastTenDaysCurrencyExchangeModels: [CurrencyExchangeModel] = []
    var currentDayExhangeRates: [CurrencyExchangeRateModel] = []
    
    private let coreModel = DIHelper().viewModel
    private let modelContext: ModelContext
    private var persistedCurrentDayExhangeRates: [CurrencyExchangeRateModel] = []
    
    // MARK: - Init
    
    init(modelContext: ModelContext, selectedViewMode: CurrencyExchangeViewMode) {
        self.modelContext = modelContext
        self.selectedViewMode = selectedViewMode
        fetchData()
        observeCurrentDateData()
        observeLastTenDaysData()
    }
    
    // MARK: - Private methods
    
    private func fetchData() {
        do {
            let descriptor = FetchDescriptor<CurrencyExchangeModel>(sortBy: [SortDescriptor(\.timestamp)])
            lastTenDaysCurrencyExchangeModels = try modelContext.fetch(descriptor)
        } catch {
            // TODO: Handle error
        }
        
        let predicate = #Predicate<CurrencyExchangeRateModel> {
            $0.isCurrentDateItem == true
        }
        
        do {
            let descriptor = FetchDescriptor<CurrencyExchangeRateModel>(predicate: predicate, sortBy: [SortDescriptor(\.timestamp)])
            let fetchedCurrentDayExhangeRates = try modelContext.fetch(descriptor)
            currentDayExhangeRates = fetchedCurrentDayExhangeRates
            persistedCurrentDayExhangeRates = fetchedCurrentDayExhangeRates
        } catch {
            // TODO: Handle error
        }
    }
    
    private func observeCurrentDateData() {
        coreModel.onChangeCurrentDay { [weak self] newState in
            if newState.loading {
                // TODO: Handle loading state
            } else if newState.error != nil {
                // TODO: Handle error
            } else {
                guard let exchangeRates = newState.launches.first?.rates else { return }
                
                self?.saveCurrentDateExhangeRates(exchangeRates)
            }
        }
    }
    
    private func observeLastTenDaysData() {
        coreModel.onChangeLastTen { [weak self] newState in
            if newState.loading {
                // TODO: Handle loading state
            } else if newState.error != nil {
                // TODO: Handle error
            } else {
                self?.saveLaunches(newState.launches)
            }
        }
    }
    
    private func saveCurrentDateExhangeRates(_ exchangeRates: [RatesItem]) {
        persistedCurrentDayExhangeRates.forEach {
            modelContext.delete($0)
        }
        
        var currencyExchangeRates: [CurrencyExchangeRateModel] = []
        
        exchangeRates.forEach {
            let currencyExchangeRate = CurrencyExchangeRateModel(
                id: $0.id,
                code: $0.code,
                currencyName: $0.currency,
                exchangeRate: $0.currencyRate, 
                isCurrentDateItem: true
            )
            
            modelContext.insert(currencyExchangeRate)
            currencyExchangeRates.append(currencyExchangeRate)
        }
        
        currentDayExhangeRates = currencyExchangeRates
    }
    
    private func saveLaunches(_ launches: [CurrencyExchangeResponseItem]) {
        do {
            // Delete all data from database
            try modelContext.delete(model: CurrencyExchangeModel.self)
        } catch {
            // TODO: Handle error
        }
        
        var currencyExchangeModels: [CurrencyExchangeModel] = []
        
        launches.forEach {
            let currencyExhange = CurrencyExchangeModel(
                id: $0.no,
                date: $0.effectiveDate,
                exchangeRates: $0.rates.map {
                    CurrencyExchangeRateModel(
                        id: $0.id,
                        code: $0.code,
                        currencyName: $0.currency,
                        exchangeRate: $0.currencyRate, 
                        isCurrentDateItem: false)
                }
            )
            currencyExchangeModels.append(currencyExhange)
            modelContext.insert(currencyExhange)
        }
        
        lastTenDaysCurrencyExchangeModels = currencyExchangeModels
    }
}
