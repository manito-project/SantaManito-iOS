//
//  Config.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 10/2/24.
//

import Foundation

enum XcodeInfoKey: String {
    case BASE_URL = "BASE_URL"
    case AMPLITUDE_API_KEY_DEBUG = "AMPLITUDE_API_KEY_DEBUG"
    case AMPLITUDE_API_KEY_PROD = "AMPLITUDE_API_KEY_PROD"
}

extension XcodeInfoKey: CaseIterable { }

struct XcodeInfo {
    public static subscript(_ key: XcodeInfoKey) -> String {
        get {
            guard let dict = Bundle.main.infoDictionary,
                  let value = dict[key.rawValue] as? String else {
                fatalError("plist cannot found.")
            }
            return value
        }
    }
}
