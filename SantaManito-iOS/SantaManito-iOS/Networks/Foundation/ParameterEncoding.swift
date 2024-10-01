//
//  ParameterEncoding.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/28/24.
//

import Foundation
import Combine

protocol ParameterEncodable {
    func encode(
        _ request: URLRequest,
        with parameters: Parameters?
    ) -> AnyPublisher<URLRequest, NetworkError>
}

extension ParameterEncodable {
    func checkValidURLData(
        _ parameters: Parameters?,
        _ url: URL?,
        _ isJsonType: Bool = false
    ) -> AnyPublisher<(Parameters, URL), NetworkError.ParameterEncoding> {
        guard let parameters else { return Fail(error: .emptyParameters).eraseToAnyPublisher() } // 인코딩할 파라미터가 없으면 에러 반환
        guard let url else { return Fail(error: .missingURL).eraseToAnyPublisher() } // URL이 없으면 에러 반환
        
        if isJsonType {
            guard JSONSerialization.isValidJSONObject(parameters) else {
                return Fail(error: .invalidJSON).eraseToAnyPublisher()
            }
            
        }
        
        return Just((parameters, url))
            .setFailureType(to: NetworkError.ParameterEncoding.self)
            .eraseToAnyPublisher()
    }
}

public struct URLEncoding: ParameterEncodable {
    func encode(_ request: URLRequest, with parameters: Parameters?) -> AnyPublisher<URLRequest, NetworkError> {
        var request = request
        
        return checkValidURLData(parameters, request.url)
            .tryMap { parameters, url -> URLRequest in
                if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
                    urlComponents.queryItems = parameters.compactMap { key, value in
                        URLQueryItem(name: key, value: "\(value)")
                    }
                    request.url = urlComponents.url
                }
                return request
            }
            .mapError { error -> NetworkError in
                if let parameterEncodingError = error as? NetworkError.ParameterEncoding {
                    return NetworkError.parameterEncodingFailed(parameterEncodingError)
                } else {
                    return NetworkError.unknown
                }
            }
            .eraseToAnyPublisher()
    }
}


public struct JSONEncoding: ParameterEncodable {
    func encode(_ request: URLRequest, with parameters: Parameters?) -> AnyPublisher<URLRequest, NetworkError> {
        var request = request
        return checkValidURLData(parameters, request.url, true) // JSON 타입으로 설정
            .tryMap { parameters, url -> URLRequest in
                do {
                    let data = try JSONSerialization.data(withJSONObject: parameters)
                    request.httpBody = data
                    return request
                } catch {
                    throw NetworkError.parameterEncodingFailed(.jsonEncodingFailed)
                }
            }
            .mapError { error in
                if let parameterEncodingError = error as? NetworkError.ParameterEncoding {
                    return NetworkError.parameterEncodingFailed(parameterEncodingError)
                } else {
                    return NetworkError.unknown
                }
            }
            .eraseToAnyPublisher()
    }
}
