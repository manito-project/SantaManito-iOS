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
    public var baseURL: String {
        let base = "Config.baseURL"
        guard URL(string: base) != nil else {
            fatalError("baseURL could not be configured")
        }
        switch Self.apiType {
        case .editRoom:
            break
        }
        return base
    }
    
    public var headers: [String: String]? {
        return APIConstants.noTokenHeader
    }
}

