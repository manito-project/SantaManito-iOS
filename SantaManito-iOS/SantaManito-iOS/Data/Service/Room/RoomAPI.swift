//
//  RoomAPI.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/30/24.
//

import Foundation

enum RoomAPI {
    case createRoom(request: CreateRoomRequest)
    case getEnteredAllRoom
    case getRoomInfo(roomID: String)
    case editRoomInfo(roomID: String, request: EditRoomRequest)
    case deleteRoom(roomID: String)
    case getMyInfo(roomID: String)
    case enterRoom(request: EnterRoomRequest)
    case matchRoom(roomID: String)
    case exitRoom(roomID: String)
    case deleteHistoryRoom(roomID: String)
}

extension RoomAPI: BaseAPI {
    var path: String? {
        switch self {
        case .createRoom:
            return Paths.createRoom
        case .getEnteredAllRoom:
            return Paths.getRooms
        case .getRoomInfo(let roomID):
            return Paths.getRoomDetail.replacingOccurrences(of: "{roomId}", with: roomID)
        case .editRoomInfo(let roomID, _):
            return Paths.editRoomInfo.replacingOccurrences(of: "{roomId}", with: roomID)
        case .deleteRoom(let roomID):
            return Paths.deleteRoom.replacingOccurrences(of: "{roomId}", with: roomID)
        case .getMyInfo(let roomID):
            return Paths.getRoomMyInfo.replacingOccurrences(of: "{roomId}", with: roomID)
        case .enterRoom:
            return Paths.enterRoom
        case .matchRoom(let roomID):
            return Paths.matchRoom.replacingOccurrences(of: "{roomId}", with: roomID)
        case .exitRoom(let roomID):
            return Paths.exitRoom.replacingOccurrences(of: "{roomId}", with: roomID)
        case .deleteHistoryRoom(let roomID):
            return Paths.deleteHistoryRoom.replacingOccurrences(of: "{roomId}", with: roomID)
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .createRoom:
            return .post
        case .getEnteredAllRoom:
            return .get
        case .getRoomInfo:
            return .get
        case .editRoomInfo:
            return .patch
        case .deleteRoom:
            return .delete
        case .getMyInfo:
            return .get
        case .enterRoom:
            return .post
        case .matchRoom:
            return .post
        case .exitRoom:
            return .delete
        case .deleteHistoryRoom:
            return .delete
        }
    }
    
    var task: RequestTask {
        switch self {
        case .createRoom(let request):
            return .requestJSONEncodable(request)
        case .getEnteredAllRoom:
            return .requestPlain
        case .getRoomInfo:
            return .requestPlain
        case .editRoomInfo(_, let request):
            return .requestJSONEncodable(request)
        case .deleteRoom:
            return .requestPlain
        case .getMyInfo:
            return .requestPlain
        case .enterRoom(let request):
            return .requestJSONEncodable(request)
        case .matchRoom:
            return .requestPlain
        case .exitRoom:
            return .requestPlain
        case .deleteHistoryRoom:
            return .requestPlain
        }
    }
}
