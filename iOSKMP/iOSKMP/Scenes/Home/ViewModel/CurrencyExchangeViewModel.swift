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
    var currentDayExchangeRates: [CurrencyExchangeRateModel] = []
    
    private let coreModel = DIHelper().viewModel
    private let dataCoordinator: DataModelActor
    
    // MARK: - Init
    
    init(dataCoordinator: DataModelActor, selectedViewMode: CurrencyExchangeViewMode) {
        self.dataCoordinator = dataCoordinator
        self.selectedViewMode = selectedViewMode
        fetchData()
        observeCurrentDateData()
        observeLastTenDaysData()
    }
    
    // MARK: - Private
    
    private func fetchData() {
        Task {
            let fetchedData = await dataCoordinator.fetchCurrencyExchangeData()
            currentDayExchangeRates = fetchedData.currencyExchangeRates
            lastTenDaysCurrencyExchangeModels = fetchedData.currencyExchangeModels
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
        Task {
            await dataCoordinator.delete(CurrencyExchangeRateModel.self)
        }
        
        var currencyExchangeRates: [CurrencyExchangeRateModel] = []
        
        exchangeRates.forEach {
            let currencyExchangeRate = CurrencyExchangeRateModel(
                referenceId: $0.id,
                code: $0.code,
                currencyName: $0.currency,
                exchangeRate: $0.currencyRate
            )
            
            currencyExchangeRates.append(currencyExchangeRate)
            
            Task {
                await dataCoordinator.add(currencyExchangeRate)
            }
        }
        
        currentDayExchangeRates = currencyExchangeRates
    }
    
    private func saveLaunches(_ launches: [CurrencyExchangeResponseItem]) {
        Task {
            await dataCoordinator.delete(CurrencyExchangeModel.self)
        }
        
        var currencyExchangeModels: [CurrencyExchangeModel] = []
        
        launches.forEach {
            let currencyExhange = CurrencyExchangeModel(
                referenceId: $0.no,
                date: $0.effectiveDate,
                exchangeRates: $0.rates.map {
                    CurrencyExchangeRate(
                        id: $0.id,
                        code: $0.code,
                        currencyName: $0.currency,
                        exchangeRate: $0.currencyRate
                    )
                }
            )
            currencyExchangeModels.append(currencyExhange)
            
            Task {
                await dataCoordinator.add(currencyExhange)
            }
        }
        
        lastTenDaysCurrencyExchangeModels = currencyExchangeModels
    }
}
