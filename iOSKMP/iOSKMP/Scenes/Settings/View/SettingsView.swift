//
//  SettingsView.swift
//  iOSKMP
//
//  Created by Timea Varga on 18.04.2024.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = true
    @AppStorage("locale") private var selectedLanguage: String = LanguageType.english.identifier
    
    @Bindable private var viewModel: SettingsViewModel
    @Bindable private var router: Router
    
    private let gitHubTitle: LocalizedStringKey = "GitHub"
    
    init(viewModel: SettingsViewModel, router: Router) {
        self.viewModel = viewModel
        self.router = router
    }
    
    var body: some View {
        NavigationStack(path: $router.navigableViews) {
            Form {
                Toggle("Dark Mode", isOn: $isDarkMode)
                
                Picker("Language", selection: $selectedLanguage) {
                    ForEach(LanguageType.allCases) { languageType in
                        Text(languageType.name)
                            .tag(languageType.identifier)
                    }
                }
                .pickerStyle(.navigationLink)
                
                HStack {
                    Text("App Size")
                    Spacer()
                    Text(viewModel.appSize)
                }
                
                HStack {
                    Text("App Version")
                    Spacer()
                    Text("v " + UIApplication.appVersion)
                }
                
                Button {
                    viewModel.goToRepository()
                } label: {
                    Picker("Repository", selection: $viewModel.repositoryIndex) {
                        Text(gitHubTitle)
                            .tag(0)
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Button {
                    viewModel.selectLibraryLicences()
                } label: {
                    NavigationLink("Open Source") {}
                }
            }
            .navigationBarTitle("")
            .navigationDestination(for: NavigableView.self) {
                $0.view
            }
        }
    }
}
