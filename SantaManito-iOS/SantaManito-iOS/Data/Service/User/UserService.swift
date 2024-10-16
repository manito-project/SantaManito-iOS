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
    func getUser(with userID: String) -> AnyPublisher<User, SMNetworkError>
    func editUsername(with username: String) -> AnyPublisher<Void, SMNetworkError>
    func deleteAccount() -> AnyPublisher<Void, SMNetworkError>
}

extension UserService: UserServiceType {
    func getUser(with userID: String) -> AnyPublisher<User, SMNetworkError> {
        requestWithResult(.getUserInfo(userID: userID), [UserResponse].self)
            .compactMap { $0.first?.toEntity() }
            .eraseToAnyPublisher()
    }
    
    func editUsername(with username: String) -> AnyPublisher<Void, SMNetworkError> {
        requestWithNoResult(.editNickname(request: .init(username: username)))
    }
    
    func deleteAccount() -> AnyPublisher<Void, SMNetworkError> {
        requestWithNoResult(.deleteAccount)
    }
    
    
}



struct StubUserService: UserServiceType {
    func deleteAccount() -> AnyPublisher<Void, SMNetworkError> {
        Just(()).setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
    }
    

    func getUser(with userID: String) -> AnyPublisher<User, SMNetworkError> {
        Future<User, SMNetworkError> { promise in
            
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                promise(.success(User(id: "123", username: "장석우")))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func editUsername(with username: String) -> AnyPublisher<Void, SMNetworkError> {
        Future<Void, SMNetworkError> { promise in
            
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                // Simulate success
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
}
