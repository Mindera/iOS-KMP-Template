//
//  AlertError.swift
//  iOSKMP
//
//  Created by timea.varga on 20.05.2024.
//

import SwiftUI

enum AlertError: LocalizedError {
  case localDataFetchFailed

  var errorDescription: String? {
    switch self {
    case .localDataFetchFailed:
      return NSLocalizedString("Failed to load data from database", comment: "")
    }
  }

  var recoverySuggestion: String? {
    switch self {
    case .localDataFetchFailed:
      return NSLocalizedString("Please try again", comment: "")
    }
  }
}
