//
//  Config.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 10/2/24.
//

import Foundation

enum Config {
    
    enum Keys {
        enum Plist {
            static let baseURL = "BASE_URL"
            static let amplitudeAPIKey = "AMPLITUDE_API_KEY"
        }
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist cannot found.")
        }
        return dict
    }()
}

extension Config {
    
    static let baseURL: String = {
        guard let key = Config.infoDictionary[Keys.Plist.baseURL] as? String else {
            fatalError("Base URL is not set in plist for this configuration.")
        }
        return key
    }()
    
    static let amplitudeAPIKey: String = {
        guard let key = Config.infoDictionary[Keys.Plist.amplitudeAPIKey] as? String else {
            fatalError("amplitudeAPIKey is not set in plist for this configuration.")
        }
        return key
    }()
}

