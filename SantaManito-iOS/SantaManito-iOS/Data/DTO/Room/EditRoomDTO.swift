//
//  EditRoomRequest.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 10/1/24.
//

import Foundation

struct EditRoomRequest: Encodable {
    var roomName: String
    var expirationDate: Date
}


extension EditRoomRequest {
    init(_ info: MakeRoomInfo) {
        self.roomName = info.name
        self.expirationDate = info.expirationDate
    }
}
