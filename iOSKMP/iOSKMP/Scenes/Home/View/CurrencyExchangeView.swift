import SwiftUI
import Charts

struct CurrencyExchangeView: View {
    @StateObject private var viewModel = CurrencyExchangeViewModel()
    @State private var selectedViewMode: CurrencyExchangeViewMode = .list
    
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
                            .scrollIndicators(.hidden)
                        } label: {
                            Text(model.date)
                        }
                    }
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
            case .graph:
                if let currentDayExhangeModel = viewModel.currentDayExhangeModel {
                    Chart {
                        ForEach(currentDayExhangeModel.exchangeRates) { exchangeRate in
                            LineMark(
                                x: .value("Code", exchangeRate.code),
                                y: .value("Rate", exchangeRate.currencyRate)
                            )
                        }
                    }
                    .padding()
                }
            }
            TabView {
                Text("Home")
                    .tabItem {
                        Image("FilledCircleIcon")
                        Text("Gold")
                    }
                Text("CHF exchange")
                    .tabItem {
                        Image("TriangleIcon")
                        Text("CHF exchange")
                    }
                Text("GBP exchange")
                    .tabItem {
                        Image("TriangleIcon")
                        Text("GBP exchange")
                    }
                Text("Settings")
                    .tabItem {
                        Image("SettingsIcon")
                        Text("Settings")
                    }
            }
        }
    }
}

#Preview {
    CurrencyExchangeView()
}
