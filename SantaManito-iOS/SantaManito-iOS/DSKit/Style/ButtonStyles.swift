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


struct SMBottomButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled: Bool
    private let colorStyle: SMButtonColorStyle
    init(_ colorStyle: SMButtonColorStyle) {
        self.colorStyle = colorStyle
    }

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(height: 52)
            .frame(maxWidth: .infinity)
            .font(.semibold_20)
            .background(isEnabled ? colorStyle.background : colorStyle.disabledBackground)
            .foregroundStyle(colorStyle.foreground)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

extension View {
    func smBottomButtonStyle(_ colorStyle: SMButtonColorStyle = .red) -> some View {
        self.buttonStyle(SMBottomButtonStyle(colorStyle))
    }
}
