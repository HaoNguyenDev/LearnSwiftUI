//
//  NavRouter.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 22/12/25.
//

import SwiftUI

protocol NavRouterProtocol: AnyObject {
    var path: NavigationPath { get set }
    
    func setRoot(to route: AnyHashable)
    func push<T: Hashable>(_ route: T, animate: Bool)
    func pop(animate: Bool)
    func pop(to route: AnyHashable)
    func pop(to route: AnyHashable, animate: Bool)
    func popToRoot()
    func replaceLast(with route: AnyHashable)
    func contains(_ subpath: AnyHashable) -> Bool
    func showSheet(_ route: Presentable)
    func showFullScreenCover(_ route: Presentable)
    func dismiss()
}

@Observable final class NavRoute: NavRouterProtocol {
    var path: NavigationPath = NavigationPath()
    var sheet: Presentable?
    var fullScreenCover: Presentable?
    private var children: [AnyHashable] = []
}

// MARK: - Methods
extension NavRoute {
    func setRoot(to route: AnyHashable) {
        path = .init()
        path.append(route)
        children.append(route)
    }
    
    func push<T: Hashable>(_ route: T, animate: Bool = true) {
        var transaction = Transaction(animation: .linear)
        transaction.disablesAnimations = !animate
        
        withTransaction(transaction) {
            path.append(route)
        }
        children.append(route)
    }
    
    func pop(animate: Bool = true) {
        guard !children.isEmpty else { return }
        var transaction = Transaction(animation: .linear)
        transaction.disablesAnimations = !animate
        
        withTransaction(transaction) {
            children.removeLast()
            path.removeLast()
        }
    }
    
    func pop(to subpath: AnyHashable) {
        guard !children.isEmpty else { return }
        
        while contains(subpath) {
            children.removeLast()
            path.removeLast()
        }
    }
    
    func pop(to route: AnyHashable, animate: Bool) {
        if animate {
            self.pop(to: route)
        } else {
            var transaction = Transaction(animation: .linear)
            transaction.disablesAnimations = !animate
            
            withTransaction(transaction) {
                self.pop(to: route)
            }
        }
    }
    
    func popToRoot() {
        while path.count > 1 {
            children.removeLast(children.count)
            path.removeLast(path.count)
        }
    }
    
//    func popToRoot() {
//        let countToRemove = path.count - 1
//
//        guard countToRemove > 0 else {
//            // Root here
//            return
//        }
//        children.removeLast(countToRemove)
//        path.removeLast(countToRemove)
//    }
    
    func replaceLast(with route: AnyHashable) {
        guard !children.isEmpty else {
            path.append(route)
            children.append(route)
            return
        }
        children.removeLast()
        path.removeLast()
        
        path.append(route)
        children.append(route)
    }
    
    func contains(_ subpath: AnyHashable) -> Bool {
        children.last != subpath && children.contains(subpath)
    }
    
    func showSheet(_ route: Presentable) {
        sheet = route
    }
    
    func showFullScreenCover(_ route: Presentable) {
        fullScreenCover = route
    }
    
    func dismiss() {
        sheet = nil
        fullScreenCover = nil
    }
}
