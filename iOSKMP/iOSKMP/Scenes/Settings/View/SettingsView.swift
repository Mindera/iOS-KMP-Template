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
    @State private var repositoryIndex = 0
    @State private var openSourceIndex = 0
    
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
                    Text("...")
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
                Picker("Open Source", selection: $openSourceIndex) {
                }
                .pickerStyle(.navigationLink)
            }
            .navigationBarTitle("")
        }
    }
}

#Preview {
    SettingsView()
}
