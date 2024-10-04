//
//  AppService.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 10/4/24.
//

import Foundation

protocol AppServiceType {
    func getLocalAppVersion() -> Version
    func getAppStoreVersion() -> Version
}

struct AppService: AppServiceType {
    
    func getLocalAppVersion() -> Version {
        guard let dictionary = Bundle.main.infoDictionary,
              let version = dictionary["CFBundleShortVersionString"] as? String
        else { return Version("0.0.0") }
        return Version(version)
    }
    
    func getAppStoreVersion() -> Version {
        guard let bundleID = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String 
        else { return Version("\(Int.max).0.0") }
        
        let appStoreUrl = "http://itunes.apple.com/lookup?bundleId=\(bundleID)"
        guard let url = URL(string: appStoreUrl),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
              let results = json["results"] as? [[String: Any]],
              let appStoreVersion = results[0]["version"] as? String
        else { return Version("0.0.0") }
        
        return Version(appStoreVersion)
    }
}

struct StubAppService: AppServiceType {
    func getLocalAppVersion() -> Version {
        return Version("2.0.0")
    }
    
    func getAppStoreVersion() -> Version {
        return Version("1.2.2")
    }
}
