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
        return Config.baseURL
    }
    
    public var headers: [String: String]? {
        return APIConstants.noTokenHeader
    }
}

