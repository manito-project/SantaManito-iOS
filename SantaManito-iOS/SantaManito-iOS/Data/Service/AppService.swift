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
    func isLatestVersion() -> AnyPublisher<Bool, Never>
    func getLocalAppVersion() -> Version
    func getAppStoreVersion() -> AnyPublisher<Version, Error>
    func getDeviceIdentifier() -> String?
}

struct AppService: AppServiceType {
    
    func isLatestVersion() -> AnyPublisher<Bool, Never> {
        getAppStoreVersion()
            .map { (appStore: $0, local: getLocalAppVersion()) }
            .map { $0.appStore <= $0.local }
            .catch { _ in return Just(true)} // 앱스토어 버전을 가져오지 못하면 항상 최신 버전으로 처리
            .eraseToAnyPublisher()
    }
    
    func getLocalAppVersion() -> Version {
        guard let dictionary = Bundle.main.infoDictionary,
              let version = dictionary["CFBundleShortVersionString"] as? String
        else { return Version("0.0.0") }
        return Version(version)
    }
    
    func getAppStoreVersion() -> AnyPublisher<Version, Error> {
        Just(())
            .tryMap {
                guard let bundleID = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String,
                      let url = URL(string: "http://itunes.apple.com/lookup?bundleId=" + bundleID)
                else { throw NSError() }
                return url
            }
            .flatMap {
                URLSession.shared.dataTaskPublisher(for: $0)
                    .tryMap { output in
                        guard let response = output.response as? HTTPURLResponse,
                              (200...299).contains(response.statusCode)
                        else {
                            throw NSError()
                        }
                        return output.data
                    }
            }
            .decode(type: [AppStoreResponse].self, decoder: JSONDecoder())
            .compactMap { $0.first?.result.version }
            .map { Version($0) }
            .eraseToAnyPublisher()
    }
    
    // App Store에 설치되어 있지 않으면 bundleID를 반환한다.
    func getDeviceIdentifier() -> String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
}

struct StubAppService: AppServiceType {
    
    func isLatestVersion() -> AnyPublisher<Bool, Never> {
        Just(true).eraseToAnyPublisher()
    }
    
    func getLocalAppVersion() -> Version {
        return Version("1.0.0")
    }
    
    func getAppStoreVersion() -> AnyPublisher<Version, Error> {
        Just(Version("1.2.2")).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func getDeviceIdentifier() -> String? {
        return "디바이스ID"
    }
}
