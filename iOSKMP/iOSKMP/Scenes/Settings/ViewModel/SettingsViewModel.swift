//
//  SettingsViewModel.swift
//  iOSKMP
//
//  Created by Timea Varga on 20.04.2024.
//

import Foundation

@Observable class SettingsViewModel {
    
    // MARK: - Properties
    
    var appSize: String = ""
    
    // MARK: - Init
    
    init() {
        DispatchQueue.global(qos: .background).async {
            self.calculateAppSize()
        }
    }
    
    // MARK: - Private methods
    
    private func calculateAppSize() {
        let bundlePath = Bundle.main.bundlePath
        let directoryEnumerator = FileManager.default.enumerator(atPath: bundlePath)
        var folderSize: Int64 = 0

        while directoryEnumerator?.nextObject() != nil {
            let fileSize = directoryEnumerator?.fileAttributes?[.size] as? Int64 ?? 0
            folderSize = folderSize + fileSize
        }
        
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useMB, .useGB]
        formatter.countStyle = .file
        
        DispatchQueue.main.async {
            self.appSize = formatter.string(fromByteCount: Int64(folderSize))
        }
    }
}
