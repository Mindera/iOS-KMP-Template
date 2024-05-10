//
//  Bundle+Extensions.swift
//  iOSKMP
//
//  Created by timea.varga on 09.05.2024.
//

import Foundation

extension Bundle {
    static func swizzleLocalization() {
        let orginalSelector = #selector(localizedString(forKey:value:table:))
        guard let orginalMethod = class_getInstanceMethod(self, orginalSelector) else { return }
        
        let modifiedSelector = #selector(modifiedLocalizedString(forKey:value:table:))
        guard let modifiedMethod = class_getInstanceMethod(self, modifiedSelector) else { return }
        
        if class_addMethod(self, orginalSelector, method_getImplementation(modifiedMethod), method_getTypeEncoding(modifiedMethod)) {
            class_replaceMethod(self, modifiedSelector, method_getImplementation(orginalMethod), method_getTypeEncoding(orginalMethod))
        } else {
            method_exchangeImplementations(orginalMethod, modifiedMethod)
        }
    }
    
    @objc private func modifiedLocalizedString(forKey key: String, value: String?, table: String?) -> String {
        guard let language = UserDefaults.standard.value(forKey: Constants.localeKey) as? String,
              let bundlePath = Bundle.main.path(forResource: language, ofType: "lproj"),
              let bundle = Bundle(path: bundlePath) else {
            return Bundle.main.modifiedLocalizedString(forKey: key, value: value, table: table)
        }
        return bundle.modifiedLocalizedString(forKey: key, value: value, table: table)
    }
}
