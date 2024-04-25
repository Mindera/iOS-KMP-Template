//
//  MenuTabViewModel.swift
//  iOSKMP
//
//  Created by Timea Varga on 25.04.2024.
//

import Foundation

@Observable class MenuTabViewModel {
    
    // MARK: - Properties
    
    var selectedTab: MenuTab
    
    private weak var delegate: TabBarCoordinatorDelegate?
    
    // MARK: - Init
    
    init(selectedTab: MenuTab, delegate: TabBarCoordinatorDelegate) {
        self.selectedTab = selectedTab
        self.delegate = delegate
    }
    
    // MARK: - Methods
    
    func selectTab(_ tab: MenuTab) {
        delegate?.didChangeSelectedTab(tab)
    }
}
