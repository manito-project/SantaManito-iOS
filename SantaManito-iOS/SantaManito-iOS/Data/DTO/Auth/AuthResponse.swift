//
//  SignUpResponse.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 10/7/24.
//

import Foundation

struct AuthResponse: Decodable {
    let id: String
    let accessToken: String
}

extension AuthResponse {
    
    func toEntity() -> AuthEntity {
        .init(userID: id, accessToken: accessToken)
    }
    
}
