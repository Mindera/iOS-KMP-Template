//
//  MenuTabView.swift
//  iOSKMP
//
//  Created by Timea Varga on 16.04.2024.
//

import SwiftUI

struct MenuTabView: View {
    @AppStorage(Constants.darkModeKey) private var isDarkMode = false
    @AppStorage(Constants.localeKey) private var selectedLanguageIdentifier = LanguageType.english.identifier
    
    @Bindable private var viewModel: MenuTabViewModel
    
    init(viewModel: MenuTabViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            HeaderView()
            
            TabView(selection: $viewModel.selectedTab) {
                Group {
                    ForEach(viewModel.tabElements) { element in
                        element.view
                            .tabItem {
                                element.item
                                    .environment(\.symbolVariants, .none)
                            }
                            .tag(element.type)
                    }
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(Color.baseColor, for: .tabBar)
                .onChange(of: viewModel.selectedTab) { oldValue, newValue in
                    viewModel.selectTab(newValue)
                }
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .environment(\.colorScheme, isDarkMode ? .dark : .light)
        .environment(\.locale, Locale(identifier: selectedLanguageIdentifier))
    }
}
