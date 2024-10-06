//
//  AuthService.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/4/24.
//

import Foundation
import Combine

enum AuthError: Error {
    case autoLoginFail
}

protocol AuthenticationServiceType {
    func signUp(nickname: String, deviceID: String) -> AnyPublisher<AuthEntity, Error>
    func signIn(deviceID: String) -> AnyPublisher<AuthEntity, Error>
}

struct StubAuthenticationService: AuthenticationServiceType {
    func signUp(nickname: String, deviceID: String) -> AnyPublisher<AuthEntity, Error> {
        Future<AuthEntity, Error> { promise in
            
            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                // Simulate success
                promise(.success(.stub))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func signIn(deviceID: String) -> AnyPublisher<AuthEntity, Error> {
        Fail(error: AuthError.autoLoginFail).eraseToAnyPublisher()
    }
}
