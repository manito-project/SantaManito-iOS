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


struct SMBottomButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled: Bool

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(height: 52)
            .frame(maxWidth: .infinity)
            .font(.semibold_20)
            .background(isEnabled ? .smRed : .smLightgray)
            .foregroundStyle(.smWhite)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

extension View {
    func smBottomButtonStyle() -> some View {
        self.buttonStyle(SMBottomButtonStyle())
    }
}
