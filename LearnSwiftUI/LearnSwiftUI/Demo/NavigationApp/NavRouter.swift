//
//  NavRouter.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//


import SwiftUI
import Foundation

final class NavRouter: NavRouterProtocol, ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    private var children: [AnyHashable] = []
}

// MARK: - Methods
extension NavRouter {
    func setRoot(to view: AnyHashable) {
        path = .init()
        path.append(view)
    }
    
    func push<T: Hashable>(_ view: T, animate: Bool = true) {
        var transaction = Transaction(animation: .linear)
        transaction.disablesAnimations = !animate
        
        withTransaction(transaction) {
            path.append(view)
        }
        children.append(view)
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
    
    func pop(to view: AnyHashable, animate: Bool) {
        if animate {
            self.pop(to: view)
        } else {
            var transaction = Transaction(animation: .linear)
            transaction.disablesAnimations = !animate
            
            withTransaction(transaction) {
                self.pop(to: view)
            }
        }
    }
    
    func popToRoot() {
        while path.count > 1 {
            children.removeLast(children.count)
            path.removeLast(path.count)
        }
    }
    
    func replaceLast(with view: AnyHashable) {
        children.removeLast()
        path.removeLast()
        
        path.append(view)
        children.append(view)
    }
    
    func contains(_ subpath: AnyHashable) -> Bool {
        children.last != subpath && children.contains(subpath)
    }
}
