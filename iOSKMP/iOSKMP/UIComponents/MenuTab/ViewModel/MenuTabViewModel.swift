//
//  MenuTabViewModel.swift
//  iOSKMP
//
//  Created by Timea Varga on 25.04.2024.
//

import Foundation

@Observable class MenuTabViewModel {
    
    // MARK: - Properties
    
    var selectedTab: MenuTabType
    var tabElements: [MenuTabElement]
    
    private weak var delegate: TabBarCoordinatorDelegate?
    
    // MARK: - Init
    
    init(selectedTab: MenuTabType, tabs: [MenuTabElement], delegate: TabBarCoordinatorDelegate) {
        self.selectedTab = selectedTab
        self.tabElements = tabs
        self.delegate = delegate
    }
    
    // MARK: - Methods
    
    func selectTab(_ tab: MenuTabType) {
        delegate?.didChangeSelectedTab(tab)
    }
}
