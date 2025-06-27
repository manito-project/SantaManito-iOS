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



//struct StubUserService: UserServiceType {
//    func deleteAccount() -> AnyPublisher<Void, SMNetworkError> {
//        Just(()).setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
//    }
//    
//
//    func getUser(with userID: String) -> AnyPublisher<User, SMNetworkError> {
//        Future<User, SMNetworkError> { promise in
//            
//            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
//                promise(.success(User(id: "123", username: "장석우")))
//            }
//        }
//        .eraseToAnyPublisher()
//    }
//    
//    func editUsername(with username: String) -> AnyPublisher<Void, SMNetworkError> {
//        Future<Void, SMNetworkError> { promise in
//            
//            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
//                // Simulate success
//                promise(.success(()))
//            }
//        }
//        .eraseToAnyPublisher()
//    }
//}
