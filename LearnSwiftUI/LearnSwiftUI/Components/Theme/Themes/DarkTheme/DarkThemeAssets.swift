//
//  DarkThemeAssets.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 13/10/25.
//

import SwiftUI

struct DarkThemeAssets: ThemeAssetsProtocol {
    var userAvatar: UIImage { R.image.manUserCircleIcon() ?? UIImage() }
    var catImage: UIImage { R.image.cat() ?? UIImage() }
    var ic_close: UIImage { R.image.ic_close() ?? UIImage() }
}
