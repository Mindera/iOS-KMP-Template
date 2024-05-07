//
//  LanguageType.swift
//  iOSKMP
//
//  Created by Timea Varga on 18.04.2024.
//

import SwiftUI

enum LanguageType: String, CaseIterable, Identifiable {
    case english
    case portuguese
    var id: Self { self }
}

extension LanguageType {
    var name: LocalizedStringKey {
        switch self {
        case .english:
            return "English"
        case .portuguese:
            return "Portuguese"
        }
    }
    
    var identifier: String {
        switch self {
        case .english:
            return "en"
        case .portuguese:
            return "pt-PT"
        }
    }
}
