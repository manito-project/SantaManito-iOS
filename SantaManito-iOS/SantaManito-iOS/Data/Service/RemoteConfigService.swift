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


enum RemoteConfigError: Error {
    case keyValueNotFound
    case unknown(Error)
}

enum SMFRCKey: String {
    case server_check
    case server_check_message
}

final class FirebaseRemoteConfigService {
    
    static let shared = FirebaseRemoteConfigService()
    
    let remoteConfig = RemoteConfig.remoteConfig()
    let settings = RemoteConfigSettings()
    
    
    private init() {
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
    }
}

extension FirebaseRemoteConfigService: RemoteConfigServiceType {
    
    func getServerCheck() -> AnyPublisher<Bool, RemoteConfigError> {
        Future<RemoteConfigValue?, Error> { [weak self] promise in
            self?.remoteConfig.fetchAndActivate { _, error in
                if let error { promise(.failure(error))}
                promise(.success(self?.remoteConfig[SMFRCKey.server_check.rawValue]))
            }
        }
        .tryMap {
            guard let serverCheck = $0?.boolValue 
            else { throw RemoteConfigError.keyValueNotFound}
            return serverCheck
        }
        .mapError {
            guard let frcError = $0 as? RemoteConfigError
            else { return RemoteConfigError.unknown($0) }
            return frcError
        }
        .eraseToAnyPublisher()
    }
    
    func getServerCheckMessage() -> AnyPublisher<String, RemoteConfigError> {
        Future<RemoteConfigValue?, Error> { [weak self] promise in
            self?.remoteConfig.fetchAndActivate { _, error in
                if let error { promise(.failure(error))}
                promise(.success(self?.remoteConfig[SMFRCKey.server_check_message.rawValue]))
            }
        }
        .tryMap {
            guard let serverCheckMessage = $0?.stringValue,
                  !serverCheckMessage.isEmpty
            else { throw RemoteConfigError.keyValueNotFound}
            
            return serverCheckMessage
        }
        .mapError {
            guard let frcError = $0 as? RemoteConfigError
            else { return RemoteConfigError.unknown($0) }
            return frcError
        }
        .eraseToAnyPublisher()
    }
    

}
