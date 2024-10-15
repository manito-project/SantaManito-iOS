//
//  MemberResponse.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 10/11/24.
//

import Foundation

struct MemberResponse: Decodable {
    let santa: UserResponse
    let manitto: UserResponse?
}

extension MemberResponse {
    func toEntity() -> Member {
        .init(santa: santa.toEntity(), manitto: manitto?.toEntity())
    }
}
