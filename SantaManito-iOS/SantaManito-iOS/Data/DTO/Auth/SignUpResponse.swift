//
//  SignUpResponse.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 10/7/24.
//

import Foundation

struct SignUpResponse: Decodable {
    let userId: String
    let accessToken: String
}

extension SignUpResponse {
    
    func toEntity() -> AuthEntity {
        .init(userID: userId, accessToken: accessToken)
    }
    
}
