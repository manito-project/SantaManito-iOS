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
    func signUp(nickname: String, deviceID: String) async throws -> AuthEntity
    func signIn(deviceID: String) async throws -> AuthEntity
}

extension AuthenticationService: AuthenticationServiceType {
    func signUp(nickname: String, deviceID: String) async throws -> AuthEntity {
        let data = try await request(.signUp(request: .init(serialNumber: deviceID, name: nickname)), as: AuthResponse.self)
        return data.toEntity()
    }

    func signIn(deviceID: String) async throws -> AuthEntity {
        let data = try await request(.signIn(request: .init(serialNumber: deviceID)), as: AuthResponse.self)
        return data.toEntity()
    }
}

struct StubAuthenticationService: AuthenticationServiceType {
    func signUp(nickname: String, deviceID: String) async throws -> AuthEntity {
        try await Task.sleep(nanoseconds: 2_000_000_000) // 2초 지연 시뮬레이션
        return .stub
    }

    func signIn(deviceID: String) async throws -> AuthEntity {
        throw SMNetworkError.invalidRequest(.unknownErr)
    }
}

