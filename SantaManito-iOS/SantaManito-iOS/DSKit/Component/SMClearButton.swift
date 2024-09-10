//
//  SMClearButton.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/10/24.
//

import Foundation
import SwiftUI

struct SMClearButton: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        
        HStack {
            content
            if !text.isEmpty {
                Button {
                    text = ""
                }label: {
                    Image(.btnCancle)
                        .foregroundColor(.smDarkgray)
                }
            }
        }
    }
}

extension View {
    func clearButton(text: Binding<String>) -> some View {
        modifier(SMClearButton(text: text))
    }
}
