//
//  Routable.swift
//  iOSKMP
//
//  Created by Timea Varga on 26.04.2024.
//

import Foundation

protocol Routable {
    func present(_ view: NavigableView)
    func popToRoot()
    func pop()
}
