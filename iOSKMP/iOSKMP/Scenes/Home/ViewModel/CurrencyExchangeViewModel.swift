//
//  ExchangeRatesViewModel.swift
//  iOSKMP
//
//  Created by Naveen Katari  on 18/03/24.
//

import CurrencyExchangeKMP

@Observable class CurrencyExchangeViewModel {
    
    // MARK: - Properties
    
    var lastTenDaysCurrencyExchangeModels: [CurrencyExchangeModel] = []
    var currentDayExhangeRates: [CurrencyExchangeRateModel] = []
    
    private let coreModel = DIHelper().viewModel
    
    // MARK: - Init
    
    init() {
        observeCurrentDateData()
        observeLastTenDaysData()
    }
    
    // MARK: - Private methods
    
    private func observeCurrentDateData() {
        coreModel.onChangeCurrentDay { [weak self] newState in
            if newState.loading {
                // TODO: Handle loading state
            } else if newState.error != nil {
                // TODO: Handle error
            } else {
                guard let exchangeRates = newState.launches.first?.rates else { return }
                
                self?.currentDayExhangeRates = exchangeRates.map {
                    CurrencyExchangeRateModel(
                        code: $0.code,
                        currencyName: $0.currency,
                        exchangeRate: $0.currencyRate,
                        id: $0.id
                    )
                }
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
                self?.lastTenDaysCurrencyExchangeModels = newState.launches.map {
                    CurrencyExchangeModel(
                        date: $0.effectiveDate,
                        exchangeRates: $0.rates.map {
                            CurrencyExchangeRateModel(
                                code: $0.code,
                                currencyName: $0.currency,
                                exchangeRate: $0.currencyRate,
                                id: $0.id)
                        },
                        id: $0.no
                    )
                }
            }
        }
    }
}
