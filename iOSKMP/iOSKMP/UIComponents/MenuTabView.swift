//
//  MenuTabView.swift
//  iOSKMP
//
//  Created by Timea Varga on 16.04.2024.
//

import SwiftUI

struct MenuTabView: View {
    @State private var selection = MenuTab.home
    
    var body: some View {
        TabView(selection: $selection) {
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
            .toolbarBackground(Color.lightYellow, for: .tabBar)
        }
        .tint(.black)
    }
}

#Preview {
    MenuTabView()
}
