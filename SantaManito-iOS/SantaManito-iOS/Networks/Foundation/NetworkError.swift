//
//  NetworkError.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/28/24.
//

import Foundation

@frozen public enum NetworkError: Error {
    case invalidURL(String)
    case parameterEnocdingFailed(ParameterEncoding)
}

extension NetworkError {
    public enum ParameterEncoding: Error {
        case missingURL
        case invalidJSON
        case jsonEncodingFailed
    }
}
