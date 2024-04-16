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
                    }
                    .tag(MenuTab.home)
                Text("")
                    .tabItem {
                        Label(MenuTab.CHFExchange.title, systemImage: MenuTab.CHFExchange.imageName)
                    }
                    .tag(MenuTab.CHFExchange)
                Text("")
                    .tabItem {
                        Label(MenuTab.GBPExchange.title, systemImage: MenuTab.GBPExchange.imageName)
                    }
                    .tag(MenuTab.GBPExchange)
                Text("")
                    .tabItem {
                        Label(MenuTab.settings.title, systemImage: MenuTab.settings.imageName)
                    }
                    .tag(MenuTab.settings)
            }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color.lightYellow, for: .tabBar)
        }
        .tint(.black)
        .onChange(of: selection) { oldState, newState in
            selection = MenuTab.home
        }
    }
}

#Preview {
    MenuTabView()
}
