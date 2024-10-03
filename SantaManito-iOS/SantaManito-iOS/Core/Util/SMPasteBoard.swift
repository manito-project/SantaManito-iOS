//
//  SMPasteBoard.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/28/24.
//

import UIKit

struct SMPasteBoard {
    static func paste(with string: String) {
        UIPasteboard.general.string = string
    }
}
