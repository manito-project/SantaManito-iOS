//
//  Config.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 10/2/24.
//

import Foundation

struct XcodeInfoKey {
    var rawValue: String
}

extension XcodeInfoKey {
    static let BASE_URL = XcodeInfoKey(rawValue: "BASE_URL")
    static let AMPLITUDE_API_KET_DEBUG = XcodeInfoKey(rawValue: "AMPLITUDE_API_KET_DEBUG")
    static let AMPLITUDE_API_KET_PROD = XcodeInfoKey(rawValue: "AMPLITUDE_API_KET_PROD")
}

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
