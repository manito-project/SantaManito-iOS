//
//  RoomAPI.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/30/24.
//

import Foundation

enum EditRoomAPI {
    case getRoomInfo(roomID: String)
    case editRoomInfo(roomID: String, request: EditRoomRequest)
    case createRoom(request: CreateRoomRequest)
    case deleteRoom(roomID: String)
}

extension EditRoomAPI: BaseAPI {
    var path: String? {
        switch self {
        case .getRoomInfo(let roomID):
            return Paths.getRoomDetail.replacingOccurrences(of: "{roomId}", with: roomID)
        case .editRoomInfo(let roomID, _):
            return Paths.editRoomInfo.replacingOccurrences(of: "{roomId}", with: roomID)
        case .createRoom:
            return Paths.createRoom
        case .deleteRoom(let roomID):
            return Paths.deleteRoom.replacingOccurrences(of: "{roomId}", with: roomID)
        }
    }
    var method: HTTPMethod {
        switch self {
        case .getRoomInfo:
            return .get
        case .editRoomInfo:
            return .patch
        case .createRoom:
            return .post
        case .deleteRoom:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .getRoomInfo:
            return .requestPlain
        case .editRoomInfo(_, let request):
            return .requestJSONEncodable(request)
        case .createRoom(let request):
            return .requestJSONEncodable(request)
        case .deleteRoom:
            return .requestPlain
        }
    }
}
