//
//  LibraryLicencesViewModel.swift
//  iOSKMP
//
//  Created by Naveen Katari  on 25/04/24.
//

import Foundation
import AcknowList

@Observable class LibraryLicencesViewModel {
    
    // MARK: - Properties
    
    var acknowledgements = [Acknow]()
    
    private weak var delegate: LibraryLicencesCoordinatorDelegate?
    
    // MARK: - Init
    
    init(delegate: LibraryLicencesCoordinatorDelegate) {
        self.delegate = delegate
        loadAcknowledgements()
    }
    
    // MARK: - Internal methods
    
    func goBack() {
        delegate?.didSelectBack()
    }
    
    // MARK: - Private methods
    
    private func loadAcknowledgements() {
        guard let url = Bundle.main.url(forResource: "Package", withExtension: "resolved"),
              let data = try? Data(contentsOf: url),
              let acknowList = try? AcknowPackageDecoder().decode(from: data) else {
            return
        }
        acknowledgements = acknowList.acknowledgements
    }
}
