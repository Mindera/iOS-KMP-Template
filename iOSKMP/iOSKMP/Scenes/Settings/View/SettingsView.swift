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
    
    @State private var viewModel = SettingsViewModel()
    @State private var repositoryIndex = 0
    
    private let gitHubTitle: LocalizedStringKey = "GitHub"
    
    var body: some View {
        NavigationView {
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
                
                Link(destination: URL(string: Constants.repositoryURL)!) {
                    Picker("Repository", selection: $repositoryIndex) {
                        Text(gitHubTitle)
                            .tag(0)
                    }
                    .pickerStyle(.navigationLink)
                }
                
                NavigationLink(destination: LibraryLicencesView()) {
                    Text("Open Source")
                }
            }
            .navigationBarTitle("")
        }
    }
}

#Preview {
    SettingsView()
}
