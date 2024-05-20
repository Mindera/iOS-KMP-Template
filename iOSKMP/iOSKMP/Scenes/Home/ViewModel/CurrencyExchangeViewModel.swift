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
    var shouldPresentAlert: Bool = false
    var alertError: AlertError?
    
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
            do {
                let fetchedData = try await dataCoordinator.fetchCurrencyExchangeData()
                
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
            } catch {
                updateErrorStateIfNeeded()
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
            let dataCoordinator = DataModelActor(modelContainer: modelContainer)
            await dataCoordinator.delete(CurrencyExchangeRateModel.self)
        }
        
        let orderedExchangeRates = exchangeRates.map {
            ExchangeRateWithTimestamp(
                exchangeRate:
                    ExchangeRate(
                        id: $0.id,
                        code: $0.code,
                        currencyName: $0.currency,
                        exchangeRate: $0.currencyRate),
                timestamp: Date()
            )
        }
        
        Task {
            let dataCoordinator = DataModelActor(modelContainer: modelContainer)
        
            await withDiscardingTaskGroup { taskGroup in
                orderedExchangeRates.forEach { ratesItem in
                    taskGroup.addTask {
                        await dataCoordinator.addCurrencyExchangeRateItem(ratesItem)
                    }
                }
            }
            
            fetchCurrencyExchangeRates()
        }
    }
    
    private func saveLaunches(_ launches: [CurrencyExchangeResponseItem]) {
        Task {
            let dataCoordinator = DataModelActor(modelContainer: modelContainer)
            await dataCoordinator.delete(CurrencyExchangeModel.self)
        }
        
        let orderedExchangeItems = launches.map {
            CurrencyExchangeWithTimestamp(
                currencyExchange:
                    CurrencyExchange(
                        id: $0.no,
                        date: $0.effectiveDate,
                        exchangeRates: $0.rates.map {
                            CurrencyExchangeRate(
                                id: $0.id,
                                code: $0.code,
                                currencyName: $0.currency,
                                exchangeRate: $0.currencyRate
                            )
                        }
                    ),
                timestamp: Date()
            )
        }
        
        Task {
            let dataCoordinator = DataModelActor(modelContainer: modelContainer)
            
            await withDiscardingTaskGroup { taskGroup in
                orderedExchangeItems.forEach { currencyExchangeItem in
                    taskGroup.addTask {
                        await dataCoordinator.addCurrencyExchangeItem(currencyExchangeItem)
                    }
                }
            }
            
            fetchLastTenDaysData()
        }
    }
    
    private func fetchCurrencyExchangeRates() {
        Task {
            do {
                let dataCoordinator = DataModelActor(modelContainer: modelContainer)
                currentDayExchangeRates = try await dataCoordinator.fetchCurrencyExchangeRates().map {
                    CurrencyExchangeRate(
                        id: $0.id,
                        code: $0.code,
                        currencyName: $0.currencyName,
                        exchangeRate: $0.exchangeRate
                    )
                }
            } catch {
                updateErrorStateIfNeeded()
            }
        }
    }
    
    private func fetchLastTenDaysData() {
        Task {
            do {
                let dataCoordinator = DataModelActor(modelContainer: modelContainer)
                lastTenDaysCurrencyExchangeModels = try await dataCoordinator.fetchCurrencyExchangeModels().map {
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
            } catch {
                updateErrorStateIfNeeded()
            }
        }
    }
    
    private func updateErrorStateIfNeeded() {
        guard !shouldPresentAlert else { return }
        
        shouldPresentAlert = true
        alertError = AlertError.localDataFetchFailed
    }
}
