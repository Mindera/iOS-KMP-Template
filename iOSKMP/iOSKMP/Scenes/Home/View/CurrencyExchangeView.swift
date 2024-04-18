import SwiftUI
import Charts

struct CurrencyExchangeView: View {
    @State private var viewModel = CurrencyExchangeViewModel()
    @State private var selectedViewMode: CurrencyExchangeViewMode = .graph
    
    var body: some View {
        VStack {
            HStack {
                Image(Constants.minderaIcon)
                    .resizable()
                    .frame(width: Constants.logoSize, height: Constants.logoSize)
                Text("Mindera")
                    .font(.system(size: Constants.headerFontSize))
            }
            
            Color.appYellow
                .frame(height: Constants.smallPadding)
            
            Picker("", selection: $selectedViewMode) {
                ForEach(CurrencyExchangeViewMode.allCases) { viewMode in
                    Text(viewMode.title)
                }
            }
            .padding()
            .pickerStyle(.segmented)
            
            switch selectedViewMode {
            case .graph:
                Chart {
                    ForEach(viewModel.currentDayExhangeRates) { exchangeRate in
                        LineMark(
                            x: .value("Currency code", exchangeRate.code),
                            y: .value("Currency rate", exchangeRate.exchangeRate)
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
    }
}

#Preview {
    CurrencyExchangeView()
}
