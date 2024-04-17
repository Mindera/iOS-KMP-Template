//
//  ExchangeRatesViewModel.swift
//  iOSKMP
//
//  Created by Naveen Katari  on 18/03/24.
//

import CurrencyExchangeKMP

class CurrencyExchangeViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var lastTenDaysCurrencyExchangeModels: [CurrencyExchangeModel] = []
    @Published var currentDayExhangeRates: [CurrencyExchangeRateModel] = []

    private let coreModel = DIHelper().viewModel
    
    // MARK: - Init
    
    init() {
        coreModel.onChangeCurrentDay { newState in
            if newState.loading {
                // TODO: Handle loading state
            } else if newState.error != nil {
                // TODO: Handle error
            } else {
                guard let exchangeRates = newState.launches.first?.rates else { return }
                
                self.currentDayExhangeRates = exchangeRates.map {
                    CurrencyExchangeRateModel(
                        code: $0.code,
                        currencyName: $0.currency,
                        exchangeRate: $0.currencyRate, 
                        id: $0.id
                    )
                }
            }
        }
        
        coreModel.onChangeLastTen { newState in
            if newState.loading {
                // TODO: Handle loading state
            } else if newState.error != nil {
                // TODO: Handle error
            } else {
                self.lastTenDaysCurrencyExchangeModels = newState.launches.map {
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
