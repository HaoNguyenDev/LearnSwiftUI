//
//  GeometryReaderDemos.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 9/1/26.
//

import Foundation

enum GeometryReaderDemos: String, CaseIterable, Identifiable {
    case stickyHeader
    case parallaxEffect
    case collapseToolbar
    case scrollBasedAnimation
    case measureTheSize
    case customPaging
    case dragGesture

    var id: String { self.rawValue }
    
    var title: String {
        switch self {
        case .stickyHeader: "Sticky Header (Header sticks when scrolling)"
        case .parallaxEffect: "Parallax Effect (slow-scrolling image)"
        case .collapseToolbar: "Collapse Toolbar (minimizes when scrolled)"
        case .scrollBasedAnimation: "Scroll-based Animation (fade / scale according to scroll)"
        case .measureTheSize: "Measure the dimensions to calculate the animation/offset."
        case .customPaging: "Custom Paging (carousel)"
        case .dragGesture: "Drag Gesture / Interactive Transition"
        }
    }
}
