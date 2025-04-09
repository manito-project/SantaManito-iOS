//
//  XcodeInfoTests.swift
//  SantaManitoUnitTests
//
//  Created by 장석우 on 4/5/25.
//

import Foundation
import Testing
@testable import SantaManito_iOS

struct XcodeInfoTests {
    
    @Test
    func xcodeInfoKey에_존재하는_키값들이_Bundle_main_infoDictionary에_존재한다() {
        XcodeInfoKey.allCases.forEach { key in
            _ = XcodeInfo[key] // 없을 경우 fatalError 반환됨
        }
    }
}
