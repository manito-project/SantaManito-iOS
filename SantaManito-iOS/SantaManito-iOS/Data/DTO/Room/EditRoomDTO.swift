//
//  EditRoomRequest.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 10/1/24.
//

import Foundation

struct EditRoomRequest: Encodable {
    var roomName: String
    var expirationDate: String
}


extension EditRoomRequest {
    init(_ info: MakeRoomInfo) {
        self.roomName = info.name
        self.expirationDate = Date().toDueDateTime //TODO: 엔티티 시간을 DTO에 맞게 변환하는 로직 필요
    }
}
