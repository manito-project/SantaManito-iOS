//
//  RoomAPI.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/30/24.
//

import Foundation

public enum EditRoomAPI {
    case getRoomInfo(roomID: String)
    //    case editRoomInfo(roomID: String, roomInfo: MakeRoomInfo)
    //    case createRoom(roomInfo: MakeRoomInfo, mission: [Mission])
}

extension EditRoomAPI: BaseAPI {
    public static var apiType: APIType = .editRoom
    
    var path: String? {
        switch self {
        case .getRoomInfo:
            return URLs.getRoomDetail
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getRoomInfo:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getRoomInfo:
            return nil
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .getRoomInfo:
            return APIConstants.noTokenHeader
        }
    }
    
    var encoder: ParameterEncodable {
        switch self {
        case .getRoomInfo:
            return URLEncoding()
        }
    }
}




