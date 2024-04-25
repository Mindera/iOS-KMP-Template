//
//  MenuTabView.swift
//  iOSKMP
//
//  Created by Timea Varga on 16.04.2024.
//

import SwiftUI

struct MenuTabView: View {
    @State private var viewModel: MenuTabViewModel
    
    init(viewModel: MenuTabViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            HeaderView()
            
            TabView(selection: $viewModel.selectedTab) {
                Group {
                    CurrencyExchangeView()
                        .tabItem {
                            Label(MenuTab.home.title, systemImage: MenuTab.home.imageName)
                                .environment(\.symbolVariants, .none)
                        }
                        .tag(MenuTab.home)
                    SettingsView()
                        .tabItem {
                            Label(MenuTab.settings.title, systemImage: MenuTab.settings.imageName)
                                .environment(\.symbolVariants, .none)
                        }
                        .tag(MenuTab.settings)
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(Color.baseColor, for: .tabBar)
                .onChange(of: viewModel.selectedTab) { oldValue, newValue in
                    viewModel.selectTab(newValue)
                }
            }
        }
    }
}
