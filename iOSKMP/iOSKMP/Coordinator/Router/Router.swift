//
//  Router.swift
//  iOSKMP
//
//  Created by Timea Varga on 26.04.2024.
//

import Foundation

@Observable final class Router {
    var navigableViews: [NavigableView] = []
}

extension Router: Routable {
    func present(_ view: NavigableView) {
        navigableViews.append(view)
    }
    
    func popToRoot() {
        navigableViews.removeAll()
    }
    
    func pop() {
        navigableViews.removeLast()
    }
}
