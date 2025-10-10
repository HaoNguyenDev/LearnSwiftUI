//
//  DefaultThemeAssets.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/10/25.
//

import Foundation
import SwiftUI

struct DefaultThemeAssets: ThemeAssetsProtocol {
    var userAvatar: UIImage { R.image.manUserCircleIcon() ?? UIImage() }
    var catImage: UIImage { R.image.cat() ?? UIImage() }
}
