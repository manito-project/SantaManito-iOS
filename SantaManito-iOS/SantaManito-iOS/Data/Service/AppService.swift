//
//  AppService.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 10/4/24.
//

import Foundation
import UIKit


protocol AppServiceType {
    func isLatestVersion() -> Bool
    func getLocalAppVersion() -> Version
    func getAppStoreVersion() -> Version
    func getDeviceIdentifier() -> String?
}

struct AppService: AppServiceType {
    
    func isLatestVersion() -> Bool {
        let local = getLocalAppVersion()
        let appStore = getAppStoreVersion()
        return local >= appStore
    }
    
    func getLocalAppVersion() -> Version {
        guard let dictionary = Bundle.main.infoDictionary,
              let version = dictionary["CFBundleShortVersionString"] as? String
        else { return Version("0.0.0") }
        return Version(version)
    }
    
    func getAppStoreVersion() -> Version {
        guard let bundleID = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String 
        else { return Version("0.0.0") }
        
        let appStoreUrl = "http://itunes.apple.com/lookup?bundleId=\(bundleID)"
        guard let url = URL(string: appStoreUrl),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
              let results = json["results"] as? [[String: Any]],
              let appStoreVersion = results[0]["version"] as? String
        else { return Version("0.0.0") }
        
        return Version(appStoreVersion)
    }
    
    // App Store에 설치되어 있지 않으면 bundleID를 반환한다.
    func getDeviceIdentifier() -> String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
}

struct StubAppService: AppServiceType {
    
    func isLatestVersion() -> Bool {
        return true
    }
    
    func getLocalAppVersion() -> Version {
        return Version("1.0.0")
    }
    
    func getAppStoreVersion() -> Version {
        return Version("1.2.2")
    }
    
    func getDeviceIdentifier() -> String? {
        return "디바이스ID"
    }
}
