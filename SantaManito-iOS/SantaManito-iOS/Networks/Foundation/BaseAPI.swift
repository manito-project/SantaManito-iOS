//
//  BaseAPI.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/30/24.
//

import Foundation

protocol BaseAPI: URLRequestTargetType { }

extension BaseAPI {
    public var url: String {
        return XcodeInfo[.BASE_URL]
    }
    
    public var headers: [String: String]? {
        return APIConstants.hasTokenHeader
    }
}

