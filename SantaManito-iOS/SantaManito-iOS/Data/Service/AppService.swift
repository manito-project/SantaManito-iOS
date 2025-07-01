//
//  AppService.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 10/4/24.
//

import Foundation
import UIKit
import Combine


protocol AppServiceType {
    func isLatestVersion() async throws -> Bool
    func getLocalAppVersion() -> Version
    func getAppStoreVersion() async throws -> Version
    func getDeviceIdentifier() -> String?
}

struct AppService: AppServiceType {
    
    func isLatestVersion() async throws -> Bool {
        do {
            let appStoreVersion = try await getAppStoreVersion()
            let localVersion = getLocalAppVersion()
            return appStoreVersion <= localVersion
        } catch {
            // 앱스토어 버전을 가져오지 못하면 항상 최신 버전으로 처리
            return true
        }
    }
    
    func getLocalAppVersion() -> Version {
        guard let dictionary = Bundle.main.infoDictionary,
              let version = dictionary["CFBundleShortVersionString"] as? String
        else { return Version("0.0.0") }
        return Version(version)
    }
    
    func getAppStoreVersion() async throws -> Version {
        guard let bundleID = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String,
              let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(bundleID)") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let appStoreResponse = try JSONDecoder().decode(AppStoreResponse.self, from: data)
        
        guard let versionString = appStoreResponse.results.first?.version else {
            throw NSError(domain: "AppStoreVersionError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Version not found"])
        }
        
        return Version(versionString)
    }
    
    
    // App Store에 설치되어 있지 않으면 bundleID를 반환한다.
    func getDeviceIdentifier() -> String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
}

//struct StubAppService: AppServiceType {
//    
//    func isLatestVersion() -> AnyPublisher<Bool, Never> {
//        Just(true).eraseToAnyPublisher()
//    }
//    
//    func getLocalAppVersion() -> Version {
//        return Version("1.0.0")
//    }
//    
//    func getAppStoreVersion() -> AnyPublisher<Version, Error> {
//        Just(Version("1.2.2")).setFailureType(to: Error.self).eraseToAnyPublisher()
//    }
//    
//    func getDeviceIdentifier() -> String? {
//        return "디바이스ID"
//    }
//}
