//
//  CreateRoomRequest.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 10/1/24.
//

import Foundation

struct CreateRoomRequest: Encodable {
    var roomName: String
    var expirationDate: String
    var missionContents: [String]
}
