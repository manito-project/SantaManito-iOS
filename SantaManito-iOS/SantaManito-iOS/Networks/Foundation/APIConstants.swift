//
//  APIConstants.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/28/24.
//

import Foundation

struct APIConstants{
    
    static let contentType = "Content-Type"
    static let applicationJSON = "application/json"
    static let multipartFormData = "multipart/form"
    static let auth = "Authorization"
    static let refresh = "RefreshToken"
    static let fcm = "FcmToken"
    
    static let boundary = "Boundary-\(UUID().uuidString)"
    
    
}

extension APIConstants{
    
    static var noTokenHeader: Dictionary<String,String> {
        [contentType: applicationJSON]
    }

    static var hasTokenHeader: Dictionary<String,String> {
        return [
            contentType: applicationJSON,
            auth : "Bearer " + UserDefaultsService.accessToken
        ]
    }
}



