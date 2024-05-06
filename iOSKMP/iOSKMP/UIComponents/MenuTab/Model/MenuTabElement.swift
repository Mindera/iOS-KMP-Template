//
//  MenuTabElement.swift
//  iOSKMP
//
//  Created by Timea Varga on 26.04.2024.
//

import SwiftUI

struct MenuTabElement: Identifiable {
    let id = UUID()
    let type: MenuTabType
    let view: AnyView
    let item: AnyView
}
