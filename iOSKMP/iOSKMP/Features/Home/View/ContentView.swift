import SwiftUI
import Charts
import CurrencyExchangeKMP

struct CurrencyExchangeView: View {
    @ObservedObject var viewModel = CurrencyExchangeViewModel()
    @State private var isListModeOn = false
    
    private let columns = [GridItem(.flexible(), spacing: 0),
                           GridItem(.flexible(), spacing: 0)]

    var body: some View {
        ScrollView {
            Toggle(isOn: $isListModeOn) {
                Text("View mode")
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            if isListModeOn {
                ForEach(viewModel.currencyExchangeModels) { model in
                    Section {
                        DisclosureGroup {
                            ForEach(model.exchangeRates) { exhangeRate in
                                HStack {
                                    Text(exhangeRate.code)
                                        .frame(minWidth: 50, alignment: .leading)
                                    Text(exhangeRate.currency)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text("\(exhangeRate.currencyRate)")
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                            }
                        } label: {
                            Text(model.date)
                        }
                    }
                }
            } else {
//                Chart {
//                    ForEach(data) { goldValue in
//                        LineMark(
//                            x: .value("Date", goldValue.date),
//                            y: .value("Value", goldValue.value)
//                        )
//                    }
//                }
            }
        }
        .padding()
    }
}

#Preview {
    CurrencyExchangeView()
}
