//
//  AppService.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 10/4/24.
//

import Foundation

protocol AppServiceType {
    func getLocalAppVersion() -> Version
}

struct AppService: AppServiceType {
    
    func getLocalAppVersion() -> Version {
        guard let dictionary = Bundle.main.infoDictionary,
              let version = dictionary["CFBundleShortVersionString"] as? String 
        else { return Version("1.0.0") }
        return Version(version)
    }
}
    
struct StubAppService: AppServiceType {
    func getLocalAppVersion() -> Version {
        return Version("1.0.0") 
    }
}
