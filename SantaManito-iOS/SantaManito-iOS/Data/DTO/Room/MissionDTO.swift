//
//  MissionResponse.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/23/24.
//

import Foundation

struct MissionResponse: Decodable {
    let id: String
    let content: String
}

extension MissionResponse {
    func toEntity() -> Mission {
        .init(content: content, id: id) // TODO: uuid string 변환
    }
}
