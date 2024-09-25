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
        .init(id: id, username: username) // TODO: manittoUserId 사용되는 값인지 확인 필요. 사용된다면 추가해야됨
    }
}
