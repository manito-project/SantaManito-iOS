//
//  EnterRoomAPI.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 10/7/24.
//

import Foundation

enum EnterRoomAPI {
    case enterRoom(request: EnterRoomRequest)
    case exitRoom(roomID: String)
}

extension EnterRoomAPI: BaseAPI {
    var path: String? {
        switch self {
        case .enterRoom:
            return Paths.enterRoom
        case .exitRoom(let roomID):
            return Paths.exitRoom.replacingOccurrences(of: "{roomId}", with: roomID)
        }
    }
    var method: HTTPMethod {
        switch self {
        case .enterRoom:
            return .post
        case .exitRoom:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .enterRoom(let request):
            return .requestJSONEncodable(request)
        case .exitRoom:
            return .requestPlain
        }
    }
}

