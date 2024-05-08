//
//  SettingsViewModel.swift
//  iOSKMP
//
//  Created by Timea Varga on 20.04.2024.
//

import SwiftUI

@Observable final class SettingsViewModel {
    
    // MARK: - Properties
    
    var appSize: String = ""
    var repositoryIndex = 0
    
    private weak var delegate: SettingsCoordinatorDelegate?
    
    // MARK: - Init
    
    init(delegate: SettingsCoordinatorDelegate) {
        self.delegate = delegate
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.calculateAppSize()
        }
    }
    
    func goToRepository() {
        delegate?.didSelectRepository()
    }
    
    func selectLibraryLicences() {
        delegate?.didSelectLibraryLicenses()
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
        
        DispatchQueue.main.async { [weak self] in
            self?.appSize = formatter.string(fromByteCount: Int64(folderSize))
        }
    }
}
