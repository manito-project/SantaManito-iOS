//
//  UserDTO.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/23/24.
//

import Foundation

struct UserResponse: Decodable {
    let id: String
    let username: String
    let manittoUserId: String?
}

extension UserResponse {
    func toEntity() -> User {
        .init(id: id, username: username)
    }
}
