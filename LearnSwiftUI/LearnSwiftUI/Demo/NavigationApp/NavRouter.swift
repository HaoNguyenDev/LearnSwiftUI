//
//  NavRouter.swift
//  SwiftUI-BaseApp
//
//  Created by Hao Nguyen on 12/7/25.
//


import SwiftUI

protocol NavRouterProtocol: AnyObject {
    var path: NavigationPath { get set }
    
    func setRoot(to view: AnyHashable)
    func push<T: Hashable>(_ view: T, animate: Bool)
    func pop(animate: Bool)
    func pop(to view: AnyHashable)
    func pop(to view: AnyHashable, animate: Bool)
    func popToRoot()
    func replaceLast(with view: AnyHashable)
    func contains(_ subpath: AnyHashable) -> Bool
    func showSheet(_ view: RouterView)
    func showFullScreenCover(_ view: RouterView)
    func dismiss()
}

@Observable final class NavRouter: NavRouterProtocol {
    var path: NavigationPath = NavigationPath()
    var sheet: RouterView?
    var fullScreenCover: RouterView?
    private var children: [AnyHashable] = []
}

// MARK: - Methods
extension NavRouter {
    func setRoot(to view: AnyHashable) {
        path = .init()
        path.append(view)
        children.append(view)
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
        guard !children.isEmpty else {
            path.append(view)
            children.append(view)
            return
        }
        children.removeLast()
        path.removeLast()
        
        path.append(view)
        children.append(view)
    }
    
    func contains(_ subpath: AnyHashable) -> Bool {
        children.last != subpath && children.contains(subpath)
    }
    
    func showSheet(_ view: RouterView) {
        sheet = view
    }
    
    func showFullScreenCover(_ view: RouterView) {
        fullScreenCover = view
    }
    
    func dismiss() {
        sheet = nil
        fullScreenCover = nil
    }
}
