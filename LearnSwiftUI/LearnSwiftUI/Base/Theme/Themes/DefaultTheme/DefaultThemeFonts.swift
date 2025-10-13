//
//  DefaultThemeFonts.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/10/25.
//

import SwiftUI

// MARK: - Primary
//
// Primary fonts are fonts that are most used by the app, usually on body text, forms, buttons, etc.

struct DefaultThemeFonts: ThemeFontProtocol {
    func bold(ofSize size: CGFloat) -> Font {
        R.font.ttHovesProTrialBd.font(size: size)
    }
    
    func heavy(ofSize size: CGFloat) -> Font {
        R.font.ttHovesProTrialBlk.font(size: size)
    }
    
    func light(ofSize size: CGFloat) -> Font {
        R.font.ttHovesProTrialLt.font(size: size)
    }
    
    func medium(ofSize size: CGFloat) -> Font {
        R.font.ttHovesProTrialMd.font(size: size)
    }
    
    func regular(ofSize size: CGFloat) -> Font {
        R.font.ttHovesProTrialRg.font(size: size)
    }
    
    func semibold(ofSize size: CGFloat) -> Font {
        R.font.ttHovesProTrialDmBd.font(size: size)
    }
    
    func thin(ofSize size: CGFloat) -> Font {
        R.font.ttHovesProTrialTh.font(size: size)
    }
    
    func ultralight(ofSize size: CGFloat) -> Font {
        R.font.ttHovesProTrialHairline.font(size: size)
    }
}

// MARK: - Secondary
//
// Secondary fonts are fonts that have different typeface from your primary, usually applied to titles, headers, etc.

extension DefaultThemeFonts {
    func boldSecondary(ofSize size: CGFloat) -> Font {
        R.font.ttHovesProTrialBd.font(size: size)
    }
    
    func mediumSecondary(ofSize size: CGFloat) -> Font {
        R.font.ttHovesProTrialMd.font(size: size)
    }
    
    func regularSecondary(ofSize size: CGFloat) -> Font {
        R.font.ttHovesProTrialRg.font(size: size)
    }
    
    func semiBoldSecondary(ofSize size: CGFloat) -> Font {
        R.font.ttHovesProTrialDmBd.font(size: size)
    }
}
