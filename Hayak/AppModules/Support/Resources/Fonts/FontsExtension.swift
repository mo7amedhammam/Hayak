//
//  FontsExtension.swift
//  MrS-Cool
//
//  Created by wecancity on 16/10/2023.
//

import SwiftUI


enum fontEnum : String {
    case light    = "LamaSans-Light"
    case regular  = "LamaSans-Regular"
    case medium   = "LamaSans-Medium"
    case semiBold = "LamaSans-SemiBold"
    case bold     = "LamaSans-Bold"
}


extension Font {
    static func Bold( size: CGFloat) -> Self {
        @State var language = LocalizeHelper.shared.currentLanguage
        return Font.custom(language == "en" ? "LamaSans-Bold":"LamaSans-Bold", size: size)
    }
    static func SemiBold( size: CGFloat) -> Self {
        @State var language = LocalizeHelper.shared.currentLanguage
        return Font.custom(language == "en" ? "LamaSans-SemiBold":"LamaSans-SemiBold", size: size)
    }
    static func Regular( size: CGFloat) -> Self {
        @State var language = LocalizeHelper.shared.currentLanguage
        return Font.custom(language == "en" ? "LamaSans-Regular":"LamaSans-Regular", size: size)
    }
    static func Light( size: CGFloat) -> Self {
        @State var language = LocalizeHelper.shared.currentLanguage
        return Font.custom(language == "en" ? "LamaSans-Light":"LamaSans-Light", size: size)
    }
    static func Medium( size: CGFloat) -> Self {
        @State var language = LocalizeHelper.shared.currentLanguage
        return Font.custom(language == "en" ? "LamaSans-Medium":"LamaSans-Medium", size: size)
    }
}

