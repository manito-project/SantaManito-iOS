//
//  EnterRoomRequest.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 10/6/24.
//

import Foundation

struct EnterRoomRequest: Encodable {
    var invitationCode: String
}

struct EnterRoomResult: Decodable {
    var roomId: String
}
