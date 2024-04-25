//
//  TabBarCoordinatorDelegate.swift
//  iOSKMP
//
//  Created by Timea Varga on 25.04.2024.
//

import Foundation

protocol TabBarCoordinatorDelegate: AnyObject {
    func didChangeSelectedTab(_ tab: MenuTab)
}
