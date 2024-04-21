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
        let bundleArray = FileManager.default.subpaths(atPath: bundlePath)
        var folderSize: Int64 = 0
        
        for file in bundleArray! {
            do {
                let attr = try FileManager.default.attributesOfItem(atPath: bundlePath + "/" + file )
                let fileSize = attr[FileAttributeKey.size] as? Int64 ?? 0
                folderSize = folderSize + fileSize
            } catch {
            }
        }
        
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useMB, .useGB]
        formatter.countStyle = .file
        
        return formatter.string(fromByteCount: Int64(folderSize))
    }
}
