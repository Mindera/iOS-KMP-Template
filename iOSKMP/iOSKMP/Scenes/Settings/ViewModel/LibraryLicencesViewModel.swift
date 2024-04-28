//
//  LibraryLicencesViewModel.swift
//  iOSKMP
//
//  Created by Naveen Katari  on 25/04/24.
//

import Foundation
import AcknowList

@Observable class LibraryLicencesViewModel {
    
    var acknowledgements = [Acknow]()
    
    private weak var delegate: LibraryLicencesCoordinatorDelegate?
    
    init(delegate: LibraryLicencesCoordinatorDelegate) {
        self.delegate = delegate
        loadAcknowledgements()
    }
    
    func goBack() {
        delegate?.didSelectBack()
    }
    
    private func loadAcknowledgements() {
        guard let url = Bundle.main.url(forResource: "Package", withExtension: "resolved"),
              let data = try? Data(contentsOf: url),
              let acknowList = try? AcknowPackageDecoder().decode(from: data) else {
            return
        }
        acknowledgements = acknowList.acknowledgements
    }
}
