//
//  AuthEntity.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 10/7/24.
//

import Foundation

struct AuthEntity {
    let userID: String
    let accessToken: String
}

extension AuthEntity {
    static var stub: Self {
        .init(userID: User.stub1.id, accessToken: "accessToken")
    }
}
