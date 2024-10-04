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
}
    
//    static var hasTokenHeader: Dictionary<String,String> {
//        [contentType: applicationJSON,
////               auth : "Bearer \(UserDefaultsManager.zoocAccessToken)"]
//    }
//    
//    static var multipartHeader: Dictionary<String,String> {
//        [contentType: multipartFormData,
//               auth : UserDefaultsManager.zoocAccessToken]
//    }
//    
//    static var multipartHeaderWithBoundary: Dictionary<String,String> {
//        [contentType: "multipart/form-data; boundary=\(APIConstants.boundary)",
//               auth : UserDefaultsManager.zoocAccessToken]
//    }
//    
//    static var refreshHeader: Dictionary<String,String> {
//        [contentType: applicationJSON,
//               auth : "Bearer \(UserDefaultsManager.zoocAccessToken)",
//             refresh: "Bearer \(UserDefaultsManager.zoocRefreshToken)",
//                 fcm: UserDefaultsManager.fcmToken]
//    }


