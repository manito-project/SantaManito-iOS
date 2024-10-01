//
//  NetworkError.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/28/24.
//

import Foundation

@frozen public enum NetworkError: Error {
    case invalidRequest(RequestError) // 요청시 생길 수 있는 에러
    case invalidResponse(ResponseError)
    case decodingFailed(DecodeError)
    case unknown
}

extension NetworkError {
    public enum RequestError: Error {
        case parameterEncodingFailed(ParameterEncoding) // 인코딩시 생기는 에러
        case invalidURL(String) // url이 유효하지 않을때
        case unknownErr // 그 외 예기치 못한 에러
    }

    public enum ParameterEncoding: Error {
        case emptyParameters // 파라미터가 비어있을 때
        case missingURL // url이 없을때
        case invalidJSON // json 형식에 맞지 않을때
        case jsonEncodingFailed // json으로 인코딩 할 시
    }
}

extension NetworkError {
    public enum ResponseError: Error {
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
    public enum DecodeError: Error {
        case failed
        case dataIsNil
    }
}
