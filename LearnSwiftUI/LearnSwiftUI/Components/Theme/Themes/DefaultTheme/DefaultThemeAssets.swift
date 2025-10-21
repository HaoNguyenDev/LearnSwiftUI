//
//  DefaultThemeAssets.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/10/25.
//

import SwiftUI

struct DefaultThemeAssets: ThemeAssetsProtocol {
    var userAvatar: UIImage { R.image.manUserCircleIcon() ?? UIImage() }
    var catImage: UIImage { R.image.cat() ?? UIImage() }
    var ic_close: UIImage { R.image.ic_close() ?? UIImage() }
}
