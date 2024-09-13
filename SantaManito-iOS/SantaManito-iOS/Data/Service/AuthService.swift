//
//  AuthService.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/4/24.
//

import Combine

enum AuthError: Error {
    case autoLoginFail
}

protocol AuthenticationServiceType {
    func autoLogin() -> AnyPublisher<Void, Error>
}

struct StubAuthenticationService: AuthenticationServiceType {
    func autoLogin() -> AnyPublisher<Void, Error> {
        Fail(error: AuthError.autoLoginFail).eraseToAnyPublisher()
    }
}
