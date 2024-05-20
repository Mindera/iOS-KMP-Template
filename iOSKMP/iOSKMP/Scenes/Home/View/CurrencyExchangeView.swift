import SwiftUI
import Charts

struct CurrencyExchangeView: View {
    @Bindable private var viewModel: CurrencyExchangeViewModel
    
    init(viewModel: CurrencyExchangeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Picker("", selection: $viewModel.selectedViewMode) {
                ForEach(CurrencyExchangeViewMode.allCases) { viewMode in
                    Text(viewMode.title)
                        .tag(viewMode)
                }
            }
            .padding()
            .pickerStyle(.segmented)
            
            switch viewModel.selectedViewMode {
            case .graph:
                Chart {
                    ForEach(viewModel.currentDayExchangeRates) { exchangeRate in
                        LineMark(
                            x: .value("", exchangeRate.code),
                            y: .value("", exchangeRate.exchangeRate)
                        )
                    }
                }
                .padding()
                .chartScrollableAxes(.horizontal)
            case .list:
                List {
                    ForEach(viewModel.lastTenDaysCurrencyExchangeModels) { model in
                        DisclosureGroup {
                            ForEach(model.exchangeRates) { exchangeRate in
                                HStack {
                                    Text(exchangeRate.code)
                                        .frame(minWidth: Constants.currencyCodeWidth, alignment: .leading)
                                    Text(exchangeRate.currencyName)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text("\(exchangeRate.exchangeRate)")
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                            }
                        } label: {
                            Text(model.date)
                        }
                    }
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
            }
        }
        .alert(isPresented: $viewModel.shouldPresentAlert, error: viewModel.alertError) { _ in
            
        } message: { error in
            if let errorMessage = error.recoverySuggestion {
                Text(errorMessage)
            }
        }
    }
}
