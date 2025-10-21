//
//  ThemeColorProtocol.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/10/25.
//

import Foundation
import SwiftUI

protocol ThemeColorProtocol {
    // Primary
    var primariesDefault: Color { get }
    var primariesShade1: Color { get }
    var primariesShade2: Color { get }
    var primariesShade3: Color { get }
    var primariesSelected: Color { get }
    var primary: Color { get }
    var brandColor: Color { get }
    
    // Text
    var textPrimary: Color { get }
    var textSecondary: Color { get }
    var textTertiary: Color { get }
    var textDisabled: Color { get }
    var textWhite: Color { get }
    var textOverImage: Color  { get }
    
    // Semantics
    var semanticsSuccessFull: Color { get }
    var semanticsSuccessSelected: Color { get }
    var semanticsWarnFull: Color { get }
    var semanticsInfoFull: Color { get }
    var semanticsInfoSecondary: Color { get }
    var semanticsErrorFull: Color { get }
    var semanticsErrorSelected: Color { get }
    
    // Neutrals
    var neutralsBackgroundPrimary: Color { get }
    var neutralsBackgroundSecondary: Color { get }
    var neutralsCards: Color { get }
    var neutralsFieldsTags: Color { get }
    var neutralsBorderDivider: Color { get }
    var neutralsButtonDisabled: Color { get }
    
    var backgroundLight: Color { get }
    var backgroundDark: Color { get }
    var backgroundTertiary: Color { get }
    var lineGrey: Color { get }
    var backgroundNew: Color { get }
    var tabbarLoading: Color { get }
    var brandColor2Positive: Color { get }
    var errorMessage: Color { get }
    var registerTextColor: Color { get }
    var registerLineGrey: Color { get }
    var registerBgColor: Color { get }
    var segmentUnselectColor: Color { get }
    var segmentSelectedColor: Color { get }
    var segmentTextColor: Color { get }
    var loginErrorTextColor: Color { get }
    var loginBtnColor: Color { get }
    var graniteGray: Color { get }
    
    var segmentDefaultBackground: Color { get }
    var segmentDefaultSelectedBackground: Color { get }
    var segmentDefaultSelectedText: Color { get }
    var segmentDefaultUnSelectedText: Color { get }
    
    // MARK: Clone from T5
    var statusBarStyle: UIStatusBarStyle { get }
    // Button colors
    var buttonPrimaryBg: Color { get }
    var buttonSecondaryBg: Color { get }
    var buttonTertiaryBg: Color { get }
    var buttonCommonBg: Color { get }
    var buttonPositiveBg: Color { get }
    var buttonNegativeBg: Color { get }
    var buttonCommonText: Color { get }
    var buttonBrandText: Color { get }
    var buttonActiveText: Color { get }
    var buttonDisableBg: Color { get }
    var buttonDisableText: Color { get }
    var buttonDisableBorder: Color { get }
    var buttonPrimaryBorder: Color { get }
    // Textfield color
    var textfieldFocusFilledBorder: Color { get }
    var textfieldFocusFailedBorder: Color { get }
    var textfieldActiveBg: Color { get }
    var textfieldDisableBg: Color { get }
    var accountHeaderBgColor: Color { get }
    var skeletonHeaderBgColor: Color { get }
    // Text
    var textBrand: Color { get }
    var textPositive: Color { get }
    var textNegative: Color { get }
    
    // Navigation bar
    var navigationBg: Color { get }
    
    // Commons
    var backgroundPrimary: Color { get }
    var eventHeaderTitle: Color {  get }
    var gray_BEBEBE: Color { get }
    var bgTertiary: Color { get }
    var tertiary: Color { get }
    var primaryLight: Color { get }
    var secondary: Color { get }
    var lightGray: Color { get }
    var divider: Color { get }
    var gainsboro: Color { get }
    var errorAndImportant: Color { get }
    var philippineSilver: Color { get }
    var disclaimerBackground: Color { get }
    var darkYellow: Color { get }
    var backgroundSecondary: Color { get }
    var lightGreen: Color { get }
    var whiteColor: Color { get }
    var red: Color { get }
    var cultured: Color { get }
    var blackColor: Color { get }
    var redLoseBackground: Color { get }
    var greenWinBackground: Color { get }
    var greyBackgroundButton: Color { get }
    var jetColor: Color { get }
    var backgroundStatus: Color { get }
    var lightBlue: Color { get }
    var backgoundCalendarSelect: Color { get }
    var lightOrange_FF8955: Color { get }
    var coralRed_F53D3D: Color { get }
    var green2Positive: Color { get }
    var silver: Color { get }
    var greyDefaultBankCard: Color { get }
    var lightCultured: Color { get }
    var pendingBackgroundStatus: Color { get }
    var successTextColor: Color { get }
    var withdrawingTextColor: Color { get }
    var withdrawingBackgroundColor: Color { get }
    var failedBackgroundColor: Color { get }
    var lightVioletColor: Color { get }
    var mediumVioletColor: Color { get }
    var white30OpacityColor: Color { get}
    var linenColor: Color { get }
    var errorAndImportant2: Color { get }
    var colorOrange: Color { get }
    var razzmatazzColor: Color { get }
    var textColorPopupLogin: Color { get }
    var userProfileHeaderBgColor: Color { get }
    var rhythm: Color { get }
    var lavenderGray: Color { get }
    var greenBold: Color { get }
    var darkGray: Color { get }
    var textGray: Color { get }
    var textGray1: Color { get }
    var textBlack: Color { get }
    var oldBrandColor: Color { get }
    var newBackgroundDisable: Color { get }
    var newTextDisable: Color { get }
    var backgroundRegisterButton: Color { get }
    var backgroundAccountView: Color { get }
    var venetianRed: Color { get }
    var blueText: Color { get }
}
