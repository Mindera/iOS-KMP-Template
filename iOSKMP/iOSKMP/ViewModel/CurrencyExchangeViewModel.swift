//
//  ExchangeRatesViewModel.swift
//  iOSKMP
//
//  Created by Naveen Katari  on 18/03/24.
//


import SwiftUI
import CurrencyExchangeKMP

enum Either<Left, Right> {
    case left(Left)
    case right(Right)
}


class CurrencyExchangeViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var launches: [CurrencyExchangeResponseItem] = []
    @Published var error: Error?

    private let getCurrencyExchangeUseCase: GetCurrencyExchangeUseCaseV1

    init() {
        self.getCurrencyExchangeUseCase = GetCurrencyExchangeUseCaseV1(
            remote: KtorCurrencyExchangeRemoteSource(
                baseUrl: "https://api.nbp.pl/api/exchangerates/tables",
                client: HttpClientKt.configureHttpClient(
                    engineFactory: Darwin(),
                    timeoutMillis: 10_000,
                    logLevel: .all
                )
            )
        )
    }

    func fetchData() {
        isLoading = true
        getCurrencyExchangeUseCase.callAsFunction { result, error in
            if let error = error {
                // Handle the NSError
                print("An error occurred: \(error.localizedDescription)")
                return
            }
            if let responseValue = result {
                result?.on(left: { dataArray in
                    guard let currencyExchangeResponseArr = dataArray as? [CurrencyExchangeResponseItem] else {return}
                    self.launches = currencyExchangeResponseArr
                }, right: { error in
                    print("Error: Data format for currency exchange response is invalid.")
                })
            }
        }
    }
}
