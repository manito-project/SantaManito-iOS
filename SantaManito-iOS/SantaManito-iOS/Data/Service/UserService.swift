//
//  UserService.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/4/24.
//

import Foundation
import Combine

protocol UserServiceType {
    func getUser(with userID: String) -> AnyPublisher<User, Error>
    func editUsername(with username: String) -> AnyPublisher<Void, Error>
}

struct StubUserService: UserServiceType {

    func getUser(with userID: String) -> AnyPublisher<User, Error> {
        Future<User, Error> { promise in
            
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                promise(.success(User(id: "123", username: "장석우")))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func editUsername(with username: String) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                // Simulate success
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
}
