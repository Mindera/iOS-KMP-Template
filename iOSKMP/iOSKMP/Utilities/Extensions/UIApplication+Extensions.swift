//
//  UIApplication+Extensions.swift
//  iOSKMP
//
//  Created by Timea Varga on 18.04.2024.
//

import UIKit

extension UIApplication {
    static var appVersion: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }
}
