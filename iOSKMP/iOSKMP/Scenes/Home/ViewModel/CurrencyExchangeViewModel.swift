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
    var lastTenDaysCurrencyExchangeModels: [CurrencyExchangeListViewModel] = []
    var currentDayExchangeRates: [CurrencyExchangeRate] = []
    
    private let coreModel = DIHelper().viewModel
    private let modelContainer: ModelContainer
    
    // MARK: - Init
    
    init(modelContainer: ModelContainer, selectedViewMode: CurrencyExchangeViewMode) {
        self.modelContainer = modelContainer
        self.selectedViewMode = selectedViewMode
        fetchData()
        observeCurrentDateData()
        observeLastTenDaysData()
    }
    
    // MARK: - Private
    
    private func fetchData() {
        Task {
            let dataCoordinator = DataModelActor(modelContainer: modelContainer)
            let fetchedData = await dataCoordinator.fetchCurrencyExchangeData()
            currentDayExchangeRates = fetchedData.currencyExchangeRates.map {
                CurrencyExchangeRate(
                    id: $0.id,
                    code: $0.code,
                    currencyName: $0.currencyName,
                    exchangeRate: $0.exchangeRate
                )
            }
            lastTenDaysCurrencyExchangeModels = fetchedData.currencyExchangeModels.map {
                CurrencyExchangeListViewModel(
                    id: $0.id,
                    date: $0.date,
                    exchangeRates: $0.exchangeRates.map {
                        CurrencyExchangeRate(
                            id: $0.id,
                            code: $0.code,
                            currencyName: $0.currencyName,
                            exchangeRate: $0.exchangeRate
                        )
                    }
                )
            }
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
                
                self?.saveCurrentDateExchangeRates(exchangeRates)
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
    
    private func saveCurrentDateExchangeRates(_ exchangeRates: [RatesItem]) {
        Task {
            let dataCoordinator = DataModelActor(modelContainer: self.modelContainer)
            await dataCoordinator.delete(CurrencyExchangeRateModel.self)
        }
        
        exchangeRates.forEach { ratesItem in
            Task {
                let timestamp = Date()
                let dataCoordinator = DataModelActor(modelContainer: modelContainer)
                await dataCoordinator.addCurrencyExchangeRateItem(
                    id: ratesItem.id,
                    code: ratesItem.code,
                    currencyName: ratesItem.currency,
                    exchangeRate: ratesItem.currencyRate, 
                    timestamp: timestamp
                )
                
                currentDayExchangeRates = await dataCoordinator.fetchCurrencyExchangeRates().map {
                    CurrencyExchangeRate(
                        id: $0.id,
                        code: $0.code,
                        currencyName: $0.currencyName,
                        exchangeRate: $0.exchangeRate
                    )
                }
            }
        }
        
        
    }
    
    private func saveLaunches(_ launches: [CurrencyExchangeResponseItem]) {
        Task {
            let dataCoordinator = DataModelActor(modelContainer: modelContainer)
            await dataCoordinator.delete(CurrencyExchangeModel.self)
        }
        
        launches.forEach { currencyExchangeResponse in
            let exchangeRates = currencyExchangeResponse.rates.map {
                CurrencyExchangeRate(
                    id: $0.id,
                    code: $0.code,
                    currencyName: $0.currency,
                    exchangeRate: $0.currencyRate
                )
            }
            
            let currencyExchangeTimestamp = Date()
            
            Task {
                let dataCoordinator = DataModelActor(modelContainer: modelContainer)
                await dataCoordinator.addCurrencyExchangeItem(
                    id: currencyExchangeResponse.no,
                    date: currencyExchangeResponse.effectiveDate,
                    exchangeRates: exchangeRates,
                    timestamp: currencyExchangeTimestamp
                )
                lastTenDaysCurrencyExchangeModels = await dataCoordinator.fetchCurrencyExchangeModels().map {
                    CurrencyExchangeListViewModel(
                        id: $0.id,
                        date: $0.date,
                        exchangeRates: $0.exchangeRates.map {
                            CurrencyExchangeRate(
                                id: $0.id,
                                code: $0.code,
                                currencyName: $0.currencyName,
                                exchangeRate: $0.exchangeRate
                            )
                        }
                    )
                }
            }
        }
        
        
    }
}
