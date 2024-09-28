//
//  View+.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/27/24.
//

import SwiftUI

extension View {
    func inputLimit(_ value: Binding<String>, maxLength: Int) -> some View {
        self.onChange(of: value.wrappedValue) { newValue in
            if newValue.count > maxLength {
                value.wrappedValue = String(newValue.prefix(maxLength))
            }
        }
    }
}
