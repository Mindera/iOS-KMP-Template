import SwiftUI
import CurrencyExchangeKMP

struct ContentView: View {
    @ObservedObject var viewModel = CurrencyExchangeViewModel()

    var body: some View {
        VStack {
            
        }
        .onAppear {
            viewModel.fetchData()
        }
    }
}
