//
//  BaseAPI.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/30/24.
//

import Foundation

public enum APIType {
    case editRoom
}

protocol BaseAPI: URLRequestTargetType {
    static var apiType: APIType { get set }
}

extension BaseAPI {
    public var url: String {
        var base = "Config.Network.baseURL"
        
        switch Self.apiType {
        case .editRoom:
            base += "/room"
        }
        return base
    }
    
    public var headers: [String: String]? {
        return APIConstants.noTokenHeader
    }
}

