//
//  AuthService.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/4/24.
//

import Foundation
import Combine

typealias AuthenticationService = BaseService<AuthAPI>

protocol AuthenticationServiceType {
    func signUp(nickname: String, deviceID: String) -> AnyPublisher<AuthEntity, SMNetworkError>
    func signIn(deviceID: String) -> AnyPublisher<AuthEntity, SMNetworkError>
}

extension AuthenticationService: AuthenticationServiceType {
    func signUp(nickname: String, deviceID: String) -> AnyPublisher<AuthEntity, SMNetworkError> {
        requestWithResult(.signUp(request: .init(serialNumber: deviceID, name: nickname)), AuthResponse.self)
            .map { $0.toEntity() }
            .eraseToAnyPublisher()
    }
    
    
    func signIn(deviceID: String) -> AnyPublisher<AuthEntity, SMNetworkError> {
        requestWithResult(.signIn(serialNumber: deviceID), AuthResponse.self)
            .map { $0.toEntity() }
            .eraseToAnyPublisher()
    }
    
    
}

struct StubAuthenticationService: AuthenticationServiceType {
    func signUp(nickname: String, deviceID: String) -> AnyPublisher<AuthEntity, SMNetworkError> {
        Future<AuthEntity, SMNetworkError> { promise in
            
            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                // Simulate success
                promise(.success(.stub))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func signIn(deviceID: String) -> AnyPublisher<AuthEntity, SMNetworkError> {
        Fail(error: SMNetworkError.invalidRequest(.unknownErr)).eraseToAnyPublisher()
    }
}
