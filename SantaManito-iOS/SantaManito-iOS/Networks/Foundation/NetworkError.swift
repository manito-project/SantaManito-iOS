//
//  NetworkError.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/28/24.
//

import Foundation

@frozen public enum NetworkError: Error {
    case invalidURL(String)
    case invalidRequest
    case parameterEnocdingFailed(ParameterEncoding)
    case invalidResponse(Int)
    case unKnownError
    case decodingFailed
    case requestFailed
}

extension NetworkError {
    public enum ParameterEncoding: Error {
        case missingURL
        case invalidJSON
        case jsonEncodingFailed
    }
}

extension NetworkError {
    public enum Response: Error {
        case cancelled
        case unhandled(error: Error?)
        case invalidStatusCode(code: Int)
        
        init(statusCode: Int, error: Error?) {
            if statusCode == 500 {
                self = .invalidStatusCode(code: statusCode)
            } else {
                self = .unhandled(error: error)
            }
        }
    }
}
