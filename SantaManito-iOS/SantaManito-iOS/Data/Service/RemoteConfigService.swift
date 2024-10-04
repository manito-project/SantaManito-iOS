//
//  RemoteConfigService.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 10/1/24.
//

import Combine
import FirebaseRemoteConfig

protocol RemoteConfigServiceType {
    func getServerCheck() -> AnyPublisher<Bool, RemoteConfigError>
    func getServerCheckMessage() -> AnyPublisher<String, RemoteConfigError>
}

// FirebaseRemoteConfig의 FIRRemoteConfigSource 는 데이터의 원천을 아래와 같이 반환한다.
// remote: 서버로부터 받아온 값
// default: 개발자가 로컬 기본값으로 설정한 값
// static: 기본값이 지정되어 있지 않은데, 서버로부터 받아오지 못한 경우
// 따라서 FIRRemoteConfigSource가 static인 경우 RemoteConfigError.keyValueNotFound 를 반환한다.

//FirebaseRemoteConfig의 RemoteConfigValue는 일치하는 키값이 없어도 기본 값을 아래와 같이 반환한다.
// boolValue = false
// stringValue = ""
// numberValue = 0
// jsonValue = nil
// data = Data()

enum RemoteConfigError: Error {
    case keyValueNotFound
    case unknown(Error)
}

enum SMFRCKey: String { //FirebaseRemoteConfig에 있는 이름값과 일치해야 함.
    case server_check
    case server_check_message
}

final class FirebaseRemoteConfigService {
    
    static let shared = FirebaseRemoteConfigService()
    
    private let remoteConfig = RemoteConfig.remoteConfig() // 싱글톤으로 관리되어야 하는 객체이기에 FirebaseRemoteConfigService도 싱글톤으로 구축.
    private let settings = RemoteConfigSettings()
    
    
    private init() {
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
    }
}

extension FirebaseRemoteConfigService: RemoteConfigServiceType {
    
    func getServerCheck() -> AnyPublisher<Bool, RemoteConfigError> {
        Future<RemoteConfigValue, Error> { promise in
            self.remoteConfig.fetchAndActivate { _, error in
                if let error { promise(.failure(error))}
                promise(.success(self.remoteConfig[SMFRCKey.server_check.rawValue]))
            }
        }
        .tryMap {
            guard $0.source != .static
            else { throw RemoteConfigError.keyValueNotFound }
            return $0.boolValue
        }
        .mapError {
            guard let frcError = $0 as? RemoteConfigError
            else { return RemoteConfigError.unknown($0) }
            return frcError
        }
        .eraseToAnyPublisher()
    }
    
    func getServerCheckMessage() -> AnyPublisher<String, RemoteConfigError> {
        Future<RemoteConfigValue, Error> {promise in
            self.remoteConfig.fetchAndActivate { _, error in
                if let error { promise(.failure(error))}
                promise(.success(self.remoteConfig[SMFRCKey.server_check_message.rawValue]))
            }
        }
        .tryMap {
            guard $0.source != .static
            else { throw RemoteConfigError.keyValueNotFound}
            return $0.stringValue
        }
        .mapError {
            guard let frcError = $0 as? RemoteConfigError
            else { return RemoteConfigError.unknown($0) }
            return frcError
        }
        .eraseToAnyPublisher()
    }
    

}
