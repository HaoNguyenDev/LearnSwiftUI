//
//  ThemeFontProtocol.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/10/25.
//

import Foundation
import SwiftUI

protocol ThemeFontProtocol {
    func bold(ofSize size: CGFloat) -> Font
    func heavy(ofSize size: CGFloat) -> Font
    func light(ofSize size: CGFloat) -> Font
    func medium(ofSize size: CGFloat) -> Font
    func regular(ofSize size: CGFloat) -> Font
    func semibold(ofSize size: CGFloat) -> Font
    func thin(ofSize size: CGFloat) -> Font
    func ultralight(ofSize size: CGFloat) -> Font
    func boldSecondary(ofSize size: CGFloat) -> Font
    func mediumSecondary(ofSize size: CGFloat) -> Font
    func regularSecondary(ofSize size: CGFloat) -> Font
    func semiBoldSecondary(ofSize size: CGFloat) -> Font
}
