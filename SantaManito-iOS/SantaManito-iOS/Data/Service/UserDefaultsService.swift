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
    var userID: String { get set }
    var accessToken: String { get set }
    func removeAll()
}

extension UserDefaultsServiceType {
    func removeAll() {
        UserDefaultKey.allCases
            .forEach {
                UserDefaults.standard.removeObject(forKey: $0.rawValue)
            }
    }
}


struct UserDefaultsService: UserDefaultsServiceType {
    static let shared = UserDefaultsService()
    private init() { }
    
    @UserDefault<String>(key: .userID, defaultValue: "") var userID: String
    @UserDefault<String>(key: .accessToken, defaultValue: "") var accessToken: String
}


struct StubUserDefaultsService: UserDefaultsServiceType {
    var userID: String = ""
    var accessToken: String = ""
}

