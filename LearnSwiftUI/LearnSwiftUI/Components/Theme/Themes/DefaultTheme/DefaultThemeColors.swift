//
//  DefaultThemeColor.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 10/10/25.
//

import UIKit
import SwiftUI

struct DefaultThemeColors: ThemeColorProtocol {
    // Primary
    let primariesDefault: Color = R.color.primariesDefault.color
    let primariesShade1: Color = R.color.primariesShade1.color
    let primariesShade2: Color = R.color.primariesShade2.color
    let primariesShade3: Color = R.color.primariesShade3.color
    var primariesSelected: Color = R.color.primariesSelected.color
    var primary: Color = Color(uiColor: UIColor.hexColor("#222222"))
    var brandColor: Color = R.color.primariesDefault.color
    
    // Text
    let textPrimary: Color = R.color.textPrimary.color
    let textSecondary: Color = R.color.textSecondary.color
    let textTertiary: Color = R.color.textTertiary.color
    let textDisabled: Color = R.color.textDisabled.color
    let textWhite: Color = R.color.textWhite.color
    let textOverImage: Color = R.color.textWhite.color
    
    // Semantics
    let semanticsSuccessFull: Color = R.color.semanticsSuccessFull.color
    var semanticsSuccessSelected: Color = R.color.semanticsSuccessSelected.color
    let semanticsWarnFull: Color = R.color.semanticsWarnFull.color
    let semanticsInfoFull: Color = R.color.semanticsInfoFull.color
    let semanticsInfoSecondary: Color = R.color.semanticsInfoSecondary.color
    let semanticsErrorFull: Color = R.color.semanticsErrorFull.color
    var semanticsErrorSelected: Color = R.color.semanticsErrorSelected.color
    
    // Neutrals
    let neutralsBackgroundPrimary: Color = R.color.neutralsBackgroundPrimary.color
    let neutralsBackgroundSecondary: Color = R.color.neutralsBackgroundSecondary.color
    let neutralsCards: Color = R.color.neutralsCards.color
    let neutralsFieldsTags: Color = R.color.neutralsFieldsTags.color
    let neutralsBorderDivider: Color = R.color.neutralsBorderDivider.color
    let neutralsButtonDisabled: Color = R.color.neutralsButtonDisabled.color
    
    let backgroundLight: Color = R.color.backgroundLight.color
    var backgroundDark: Color = R.color.backgroundDark.color
    let backgroundTertiary: Color = R.color.backgroundTetiary.color
    let lineGrey: Color = Color(uiColor: UIColor.hexColor("#E0E0E0"))
    let backgroundNew: Color = Color(uiColor: UIColor.hexColor("#F83C00"))
    var tabbarLoading: Color = R.color.gray_EDEDED.color
    var brandColor2Positive: Color = R.color.brandColor2Positive.color
    var errorMessage: Color = R.color.errorMessage.color
    var registerTextColor: Color = Color(uiColor: UIColor.hexColor("#F83C00"))
    var registerLineGrey: Color = Color(uiColor: UIColor.hexColor("#999999"))
    var registerBgColor: Color = Color(uiColor: UIColor.hexColor("#EBEBEB"))
    var segmentUnselectColor: Color = Color(uiColor: UIColor.hexColor("#CCCCCC"))
    var segmentSelectedColor: Color = Color(uiColor: UIColor.hexColor("#FFFFFF"))
    var segmentTextColor: Color = Color(uiColor: UIColor.hexColor("#222222"))
    var loginErrorTextColor: Color = Color(uiColor: UIColor.hexColor("#FF262E"))
    var loginBtnColor: Color = Color(uiColor: UIColor.hexColor("#00C036"))
    var graniteGray: Color = Color(hex: "#666666")
    
    var segmentDefaultBackground: Color = Color(uiColor: UIColor.hexColor("#D9D9D9"))
    var segmentDefaultSelectedBackground: Color = Color(uiColor: UIColor.hexColor("#FFFFFF"))
    var segmentDefaultSelectedText: Color = Color(uiColor: UIColor.hexColor("#000000"))
    var segmentDefaultUnSelectedText: Color = Color(uiColor: UIColor.hexColor("#666666"))
    
    var statusBarStyle: UIStatusBarStyle { .lightContent }

    var buttonPrimaryBg: Color { Color.hexColor("#F83C00") }
    var buttonSecondaryBg: Color { .clear }
    var buttonTertiaryBg: Color { .clear }
    var buttonCommonBg: Color { Color.hexColor("#FFFFFF") }
    var buttonPositiveBg: Color { Color.hexColor("#00C036") }
    var buttonNegativeBg: Color { Color.hexColor("#FF262E") }
    var buttonCommonText: Color { Color.hexColor("#222222") }
    var buttonBrandText: Color { Color.hexColor("#F83C00") }
    var buttonActiveText: Color { Color.hexColor("#FFFFFF") }
    var buttonDisableBg: Color { Color.hexColor("#E0E0E0") }
    var buttonDisableText: Color { Color.hexColor("#999999") }
    var buttonDisableBorder: Color { Color.hexColor("#E0E0E0") }
    var buttonPrimaryBorder: Color { Color.hexColor("#E03800") }
    var textfieldFocusFilledBorder: Color { Color.hexColor("#33C85D") }
    var textfieldFocusFailedBorder: Color { Color.hexColor("#FF262E") }
    var textfieldActiveBg: Color { Color.hexColor("#FFFFFF") }
    var textfieldDisableBg: Color { Color.hexColor("#E0E0E0") }
    var textBrand: Color { Color.hexColor("#F83C00") }
    var textPositive: Color { Color.hexColor("#00C036") }
    var textNegative: Color { Color.hexColor("#F01616") }
    var navigationBg: Color { Color.hexColor("#000000") }
    var backgroundPrimary: Color { Color.hexColor("#EBEBEB") }
    var eventHeaderTitle: Color {  Color.hexColor( "#222222") }
    var gray_BEBEBE: Color { .hexColor("#BEBEBE") }
    var bgTertiary: Color { Color.hexColor("#F2F2F2") }
    var tertiary: Color { Color.hexColor("#999999") }
    var primaryLight: Color { Color.hexColor("#FFF1ED") }
    var secondary: Color { Color.hexColor("#666666")}
    var lightGray: Color { Color.hexColor("#E0E0E0") }
    var divider: Color { Color.hexColor("#E6E6E6") }
    var gainsboro: Color { Color.hexColor("#DDDDDD")}
    var errorAndImportant: Color { Color.hexColor("#F01616") }
    var philippineSilver: Color { Color.hexColor("#B1B1B3") }
    var disclaimerBackground: Color { Color.hexColor("#FFF5BF") }
    var darkYellow: Color { Color.hexColor("#998200") }
    var backgroundSecondary: Color { .hexColor("#FFFFFF")}
    var lightGreen: Color { Color.hexColor("#1FD1A1") }
    var whiteColor: Color { .hexColor("#FFFFFF")}
    var red: Color { .hexColor("#F01F1F") }
    var cultured: Color { Color.hexColor("#F5F5F5") }
    var blackColor: Color { Color.hexColor("#000000") }
    var redLoseBackground: Color { Color.hexColor("#FFDEDE") }
    var greenWinBackground: Color { Color.hexColor("#DDFFE5") }
    var greyBackgroundButton: Color { Color.hexColor("#F2F2F2") }
    var jetColor: Color { Color.hexColor("#363636") }
    var backgroundStatus: Color { Color.hexColor("#E6EFFF") }
    var lightBlue: Color { Color.hexColor("#0058C0") }
    var backgoundCalendarSelect: Color { Color.hexColor("#FFF1ED") }
    var lightOrange_FF8955: Color { .hexColor("#FF8955") }
    var coralRed_F53D3D: Color { Color.hexColor("#F53D3D") }
    var green2Positive: Color { Color.hexColor("#00C036") }
    var silver: Color { Color.hexColor("#CCCCCC") }
    var greyDefaultBankCard: Color { Color.hexColor("#FFE8F9") }
    var lightCultured: Color { Color.hexColor("#F4F4F4") }
    var pendingBackgroundStatus: Color { Color.hexColor("#E6EFFF") }
    var successTextColor: Color { Color.hexColor("#14C36B") }
    var withdrawingTextColor: Color { Color.hexColor("#4AA4FF") }
    var withdrawingBackgroundColor: Color { Color.hexColor("#DDF7FF") }
    var failedBackgroundColor: Color { Color.hexColor("#FFDDDD") }
    var lightVioletColor: Color { Color.hexColor("#8C4EFF") }
    var mediumVioletColor: Color { Color.hexColor("#6B3FFC") }
    var white30OpacityColor: Color { Color(uiColor: UIColor.hexColor("#FFFFFF", alpha: 0.3))}
    var linenColor: Color { Color.hexColor("#FFEDE6")}
    var errorAndImportant2: Color { Color.hexColor("#FF262E")}
    var colorOrange: Color { Color.hexColor("#FD6B3C") }
    var razzmatazzColor: Color { Color.hexColor("#F42766") }
    var textColorPopupLogin: Color { Color.hexColor("#F83C00") }
    var accountHeaderBgColor: Color { Color.hexColor("#FD6B3C") }
    var skeletonHeaderBgColor: Color { Color.hexColor("#222222") }
    var userProfileHeaderBgColor:  Color { Color.hexColor("#FD6B3C") }
    var rhythm: Color { Color.hexColor("#6F7AA4") }
    var lavenderGray: Color { Color.hexColor("#C0C5D7") }
    var greenBold: Color { Color.hexColor("#00CE3A") }
    var darkGray: Color { Color.hexColor("#262B33") }
    var textGray: Color { Color.hexColor("#999999") }
    var textGray1: Color { Color.hexColor("#5A5D62") }
    var textBlack: Color { Color.hexColor("#262B33") }
    var oldBrandColor: Color { Color.hexColor("#F83C00") }
    var newBackgroundDisable: Color { Color.hexColor("#E0E0E0") }
    var newTextDisable: Color { Color.hexColor("#999999") }
    var backgroundRegisterButton: Color { Color.hexColor("#00C036") }
    var backgroundAccountView: Color { Color.hexColor("#FD6B3C") }
    var venetianRed: Color = Color(hex: "#FD6B3C")
    var blueText: Color = R.color.blueText.color
}
