//
//  RoomAPI.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/30/24.
//

import Foundation

enum EditRoomAPI {
    //    case getRoomInfo(roomID: String)
    case editRoomInfo(roomId: String, request: EditRoomRequest)
    case createRoom(request: CreateRoomRequest)
}

extension EditRoomAPI: BaseAPI {
    
    var path: String? {
        switch self {
            //        case .getRoomInfo:
            //            return URLs.getRoomDetail
        case .editRoomInfo(let roomId, _):
            return Paths.editRoomInfo.replacingOccurrences(of: "{roomId}", with: roomId)
        case .createRoom:
            return Paths.createRoom
        }
    }
    var method: HTTPMethod {
        switch self {
            //        case .getRoomInfo:
            //            return .get
        case .editRoomInfo:
            return .patch
        case .createRoom:
            return .post
        }
    }
    
    var parameters: Parameters? {
        switch self {
            //        case .getRoomInfo:
            //            return nil
        case .editRoomInfo(_, let request): [
            "roomName": request.roomName,
            "expirationDate": request.expirationDate
        ]
        case .createRoom(let request): [
            "roomName": request.roomName,
            "expirationDate": request.expirationDate,
            "missionContents": request.missionContents
        ]
        }
    }
    
    var encoder: ParameterEncodable {
        switch self {
            //        case .getRoomInfo:
            //            return URLEncoding()
        case .editRoomInfo:
            return JSONEncoding()
        case .createRoom:
            return JSONEncoding()
        }
    }
}




