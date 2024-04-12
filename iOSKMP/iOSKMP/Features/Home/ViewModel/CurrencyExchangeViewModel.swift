//
//  ExchangeRatesViewModel.swift
//  iOSKMP
//
//  Created by Naveen Katari  on 18/03/24.
//

import CurrencyExchangeKMP

class CurrencyExchangeViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var currencyExchangeModels: [CurrencyExchangeModel] = []
    @Published var error: Error?

    private let coreModel = DIHelper().viewModel
    
    init() {
        coreModel.onChangeCurrentDay { newState in
            if newState.loading {
                print("Loading CurrentDay")
            } else if newState.error != nil {
                print("Error CurrentDay: \(String(describing: newState.error))")
            } else {
                print("Response CurrentDay: \(newState.launches)\n\n -------------")
            }
        }
        
        coreModel.onChangeLastTen { newState in
            if newState.loading {
                print("Loading")
            } else if newState.error != nil {
                print("Error: \(String(describing: newState.error))")
            } else {
                self.currencyExchangeModels = newState.launches.map { CurrencyExchangeModel(date: $0.effectiveDate, exchangeRates: $0.rates.map { CurrencyExchangeRateModel(code: $0.code, currency: $0.currency, currencyRate: $0.currencyRate)}) }
            }
        }
    }
}
