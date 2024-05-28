//
//  ExchangeRatesViewModel.swift
//  iOSKMP
//
//  Created by Naveen Katari  on 18/03/24.
//

import CurrencyExchangeKMP

@Observable final class CurrencyExchangeViewModel {
    
    // MARK: - Properties
    
    var selectedViewMode: CurrencyExchangeViewMode
    var lastTenDaysCurrencyExchangeModels: [CurrencyExchangeModel] = []
    var currentDayExhangeRates: [CurrencyExchangeRateModel] = []
    
    private let coreModel = DIHelper().viewModel
    
    // MARK: - Init
    
    init(selectedViewMode: CurrencyExchangeViewMode) {
        self.selectedViewMode = selectedViewMode
        observeCurrentDateData()
        observeLastTenDaysData()
    }
    
    // MARK: - Private
    
    private func observeCurrentDateData() {
        coreModel.onChangeCurrentDay { [weak self] newState in
            if newState.loading {
                // TODO: Handle loading state
            } else if newState.error != nil {
                // TODO: Handle error
            } else {
                guard let exchangeRates = newState.currencyExchange.first?.rates else { return }
                
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
                self?.lastTenDaysCurrencyExchangeModels = newState.currencyExchange.map {
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
