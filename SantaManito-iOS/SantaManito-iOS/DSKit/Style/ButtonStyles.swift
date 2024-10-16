//
//  ButtonStyle.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/4/24.
//

import SwiftUI

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

struct SMButtonColorStyle {
    let background: Color
    let foreground: Color
    let disabledBackground: Color
}

extension SMButtonColorStyle {
    static let red = SMButtonColorStyle(background: .smRed, foreground: .smWhite, disabledBackground: .smLightgray)
    static let darkgray = SMButtonColorStyle(background: .smDarkgray, foreground: .smWhite, disabledBackground: .smLightgray)
}

enum SMButtonSizeStyle {
    case large
    case medium
    
    var height: CGFloat {
        switch self {
        case .large:
            52
        case .medium:
            52
        }
    }
    
    var font: Font {
        switch self {
        case .large:
            return .semibold_20
        case .medium:
            return .semibold_16
        }
    }
}


struct SMBottomButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    private let colorStyle: SMButtonColorStyle
    private let sizeStyle: SMButtonSizeStyle
    
    init(_ colorStyle: SMButtonColorStyle, _ sizeStyle : SMButtonSizeStyle) {
        self.colorStyle = colorStyle
        self.sizeStyle = sizeStyle
    }

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(height: sizeStyle.height)
            .frame(maxWidth: .infinity)
            .font(sizeStyle.font)
            .background(isEnabled ? colorStyle.background : colorStyle.disabledBackground)
            .foregroundStyle(colorStyle.foreground)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

extension View {
    func smBottomButtonStyle(_ colorStyle: SMButtonColorStyle = .red, _ sizeStyle: SMButtonSizeStyle = .large) -> some View {
        self.buttonStyle(SMBottomButtonStyle(colorStyle, sizeStyle))
    }
}
