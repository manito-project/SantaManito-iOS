//
//  UserDefaultService.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 10/7/24.
//

import Foundation

enum UserDefaultKey: String, CaseIterable {
    case userID
    case accessToken
}

protocol UserDefaultsServiceType {
    static var userID: String { get set }
    static var accessToken: String { get set }
}

struct UserDefaultsService: UserDefaultsServiceType {
    @UserDefault<String>(key: .userID, defaultValue: "") static var userID: String
    @UserDefault<String>(key: .accessToken, defaultValue: "") static var accessToken: String
}


struct StubUserDefaultsService: UserDefaultsServiceType {
    static var userID: String = ""
    static var accessToken: String = ""
}

extension UserDefaultsServiceType {
    static func reset() {
        UserDefaultKey.allCases
            .forEach {
                UserDefaults.standard.removeObject(forKey: $0.rawValue)
            }
    }
}
