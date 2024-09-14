//
//  UserService.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/4/24.
//

import Foundation
import Combine

protocol UserServiceType {
    func signUp(nickname: String) -> AnyPublisher<Void, Error>
}

struct StubUserService: UserServiceType {
    func signUp(nickname: String) -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            
            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                // Simulate success
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
}
