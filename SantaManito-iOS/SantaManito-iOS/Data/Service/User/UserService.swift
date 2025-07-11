//
//  UserService.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/4/24.
//

import Foundation
import Combine

typealias UserService = BaseService<UserAPI>

protocol UserServiceType {
    func getUser(with userID: String) async throws -> User
    func editUsername(with username: String) async throws
    func deleteAccount() async throws
}

extension UserService: UserServiceType {
    func getUser(with userID: String) async throws -> User {
        let data = try await request(.getUserInfo(userID: userID), as: [UserResponse].self)
        return (data.first?.toEntity())!
    }
    
    func editUsername(with username: String) async throws {
        try await request(.editNickname(request: .init(username: username)))
    }
    
    func deleteAccount() async throws {
        try await request(.deleteAccount)
    }
}



struct StubUserService: UserServiceType {
    func getUser(with userID: String) async throws -> User {
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1초 지연
        return User(id: "123", username: "장석우")
    }

    func editUsername(with username: String) async throws {
        try await Task.sleep(nanoseconds: 500_000_000) // 0.5초 지연
        // 성공적으로 완료됨을 시뮬레이션
    }

    func deleteAccount() async throws {
        try await Task.sleep(nanoseconds: 300_000_000) // 0.3초 지연
        // 성공적으로 완료됨을 시뮬레이션
    }
}

