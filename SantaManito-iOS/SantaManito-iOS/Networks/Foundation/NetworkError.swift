//
//  NetworkError.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/28/24.
//

import Foundation

@frozen public enum NetworkError: Error {
    case invalidRequest(Request)
    case invalidResponse(Response)
    case decodingFailed
    case unknown
}

extension NetworkError {
    public enum Request: Error {
        case parameterEncodingFailed(ParameterEncoding)
        case invalidURL(String)
    }

    public enum ParameterEncoding: Error {
        case emptyParameters
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

extension NetworkError {
    public enum Decode: Error {
        case failed
        case dataIsNil
    }
}
