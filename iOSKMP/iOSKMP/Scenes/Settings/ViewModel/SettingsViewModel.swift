//
//  SettingsViewModel.swift
//  iOSKMP
//
//  Created by Timea Varga on 20.04.2024.
//

import Foundation

@Observable class SettingsViewModel {
    
    // MARK: - Properties
    
    var appSize: String {
        calculateAppSize()
    }
    
    // MARK: - Private methods
    
    private func calculateAppSize() -> String {
        let bundlePath = Bundle.main.bundlePath
        var folderSize: Int64 = 0
        
        let directoryEnumerator = FileManager.default.enumerator(atPath: bundlePath)

        while let file = directoryEnumerator?.nextObject() as? String {
            let fileSize = directoryEnumerator?.fileAttributes?[.size] as? Int64 ?? 0
            folderSize = folderSize + fileSize
        }
        
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useMB, .useGB]
        formatter.countStyle = .file
        
        return formatter.string(fromByteCount: Int64(folderSize))
    }
}
