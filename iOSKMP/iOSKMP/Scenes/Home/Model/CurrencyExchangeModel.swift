//
//  CurrencyExchangeModel.swift
//  iOSKMP
//
//  Created by timea.varga on 13.05.2024.
//

import SwiftData
import Foundation

@Model
final class CurrencyExchangeModel {
    @Attribute(.unique) var id: String
    var date: String
    @Relationship(deleteRule: .cascade) var exchangeRates: [CurrencyExchangeRateModel]
    var timestamp: Date
    
    init(id: String, date: String, exchangeRates: [CurrencyExchangeRateModel], timestamp: Date = Date()) {
        self.id = id
        self.date = date
        self.exchangeRates = exchangeRates
        self.timestamp = timestamp
    }
}
