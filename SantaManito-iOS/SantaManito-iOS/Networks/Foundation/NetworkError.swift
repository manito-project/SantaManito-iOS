//
//  NetworkError.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/28/24.
//

import Foundation

@frozen public enum NetworkError: Error {
    case invalidRequest
    case parameterEncodingFailed(ParameterEncoding)
    case invalidResponse(Int)
    case unknown
    case decodingFailed
    case requestFailed(RequestError)
}

extension NetworkError {
    public enum RequestError: Error {
        case error(Error)
        case invalidURL(String)
        case invalidRequest
    }
}

extension NetworkError {
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
