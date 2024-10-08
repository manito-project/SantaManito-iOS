//
//  AppStoreResponse.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 10/8/24.
//

import Foundation

struct AppStoreResponse: Decodable {
    let result: AppStoreResultResponse
}

struct AppStoreResultResponse: Decodable {
    let version: String
}

