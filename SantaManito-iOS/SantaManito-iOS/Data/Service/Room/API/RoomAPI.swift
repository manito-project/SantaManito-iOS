//
//  RoomAPI.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/30/24.
//

import Foundation

enum RoomAPI {
    case getRoomInfo(roomID: String)
    case editRoomInfo(roomId: String, request: EditRoomRequest)
    case createRoom(request: CreateRoomRequest)
    case enterRoom(request: EnterRoomRequest)
}

extension RoomAPI: BaseAPI {
    
    var path: String? {
        switch self {
        case .getRoomInfo(let roomId):
            return Paths.getRoomDetail.replacingOccurrences(of: "{roomId}", with: roomId)
        case .editRoomInfo(let roomId, _):
            return Paths.editRoomInfo.replacingOccurrences(of: "{roomId}", with: roomId)
        case .createRoom:
            return Paths.createRoom
        case .enterRoom:
            return Paths.enterRoom
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
        case .enterRoom:
            return .post
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getRoomInfo:
            return nil
        case .editRoomInfo(_, let request): 
            return [
                "roomName": request.roomName,
                "expirationDate": request.expirationDate
            ]
        case .createRoom(let request): 
            return [
                "roomName": request.roomName,
                "expirationDate": request.expirationDate,
                "missionContents": request.missionContents
            ]
        case .enterRoom(let request):
            return [
                "invitationCode" : request.inviteCode
            ]
        }
    }
    
    var encoder: ParameterEncodable? {
        switch self {
        case .getRoomInfo:
            return nil
        case .editRoomInfo:
            return JSONEncoding()
        case .createRoom:
            return JSONEncoding()
        case .enterRoom:
            return JSONEncoding()
        }
    }
}




