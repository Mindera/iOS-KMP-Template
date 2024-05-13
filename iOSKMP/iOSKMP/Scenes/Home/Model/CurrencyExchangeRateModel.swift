//
//  CurrencyExchangeRateModel.swift
//  iOSKMP
//
//  Created by timea.varga on 13.05.2024.
//

import SwiftData
import Foundation

@Model
final class CurrencyExchangeRateModel {
    @Attribute(.unique) var id: String
    var code: String
    var currencyName: String
    var exchangeRate: Double
    var isCurrentDateItem: Bool
    var timestamp: Date
    
    init(id: String, code: String, currencyName: String, exchangeRate: Double, isCurrentDateItem: Bool, timestamp: Date = Date()) {
        self.id = id
        self.code = code
        self.currencyName = currencyName
        self.exchangeRate = exchangeRate
        self.isCurrentDateItem = isCurrentDateItem
        self.timestamp = timestamp
    }
}
