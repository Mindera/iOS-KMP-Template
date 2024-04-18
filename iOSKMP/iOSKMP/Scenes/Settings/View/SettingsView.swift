//
//  SettingsView.swift
//  iOSKMP
//
//  Created by Timea Varga on 18.04.2024.
//

import SwiftUI

struct SettingsView: View {
    @State private var isDarkModeSelected = false
    @State private var selectedLanguage: LanguageType = .english
    @State private var repositoryIndex = 0
    @State private var openSourceIndex = 0
    
    var body: some View {
        NavigationView {
            Form {
                Toggle("Dark Mode", isOn: $isDarkModeSelected)
                Picker("Language", selection: $selectedLanguage) {
                    ForEach(LanguageType.allCases) { languageType in
                        Text(languageType.name).tag(languageType)
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
                Picker("Repository", selection: $repositoryIndex) {
                    Text("GitHub")
                }
                .pickerStyle(.navigationLink)
                Picker("Open Source", selection: $openSourceIndex) {
                }
                .pickerStyle(.navigationLink)
            }
        }
    }
}

#Preview {
    SettingsView()
}
