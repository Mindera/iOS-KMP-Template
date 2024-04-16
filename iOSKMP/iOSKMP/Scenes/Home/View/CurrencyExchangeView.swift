import SwiftUI
import Charts

struct CurrencyExchangeView: View {
    @StateObject private var viewModel = CurrencyExchangeViewModel()
    @State private var selectedViewMode: CurrencyExchangeViewMode = .graph
    
    var body: some View {
        VStack {
            HStack {
                Image("MinderaIcon")
                    .resizable()
                    .frame(width: 50.0, height: 50.0)
                Text("Mindera")
                    .font(.system(size: 25.0))
            }
            
            Color.appYellow
                .frame(height: 10.0)
            
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
                            x: .value("Code", exchangeRate.code),
                            y: .value("Rate", exchangeRate.currencyRate)
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
                                        .frame(minWidth: 50, alignment: .leading)
                                    Text(exchangeRate.currency)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text("\(exchangeRate.currencyRate)")
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
