//
//  Text+.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/9/24.
//

import SwiftUI

struct ColoredTextView: View {
    let fullText: String
    let coloredWord: String
    let color: Color

    var body: some View {
        let parts = fullText.components(separatedBy: coloredWord)
        if parts.count > 1 {
            return Text(parts[0]) + Text(coloredWord).foregroundColor(color) + Text(parts[1])
        } else {
            return Text(fullText) // coloredWord가 포함되지 않는 경우
        }
    }
}
