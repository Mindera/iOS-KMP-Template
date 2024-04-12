import SwiftUI
import Charts
import CurrencyExchangeKMP

struct CurrencyExchangeView: View {
    @ObservedObject var viewModel = CurrencyExchangeViewModel()
    @State private var isListModeOn = false
    
    private let columns = [GridItem(.flexible(), spacing: 0),
                           GridItem(.flexible(), spacing: 0)]

    var body: some View {
        VStack {
            Toggle(isOn: $isListModeOn) {
                Text("View mode")
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            if isListModeOn {
                LazyVGrid(columns: columns, alignment: .center, spacing: 0) {
                    ForEach(viewModel.currencyExchangeModels) { currencyExchangeModel in
                        Text(currencyExchangeModel.date)
                            .padding([.trailing], 5)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .frame(height: 40)
                            .border(Color.black)
                    }
                }
                .padding()
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
