//
//  TextFieldStyles.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/10/24.
//

import Foundation
import SwiftUI

struct SMTextFieldStlyes: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.medium_16)
            .foregroundColor(.smDarkgray)
            .padding(.vertical, 16)
            .padding(.leading, 12)
            .frame(height: 48)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.smLightgray, lineWidth: 1)
            }
    }
}

extension View {
    func smTextFieldStyle() -> some View {
        self.textFieldStyle(SMTextFieldStlyes())
    }
}
