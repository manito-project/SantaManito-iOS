//
//  ParameterEncoding.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/28/24.
//

import Foundation

protocol ParameterEncodable {
    func encode(
        _ request: URLRequest,
        with parameters: Parameters?
    ) throws -> URLRequest
}

public struct URLEncoding: ParameterEncodable {
    func encode(_ request: URLRequest, with parameters: Parameters?) throws -> URLRequest {
        var request = request
        guard let parameters else { return request }
        guard let url = request.url else {
            throw NetworkError.parameterEnocdingFailed(.missingURL)
        }
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            urlComponents.queryItems = parameters.compactMap { key, value in
                return URLQueryItem(name: key, value: "\(value)")
            }
            request.url = urlComponents.url
        }
        return request
    }
}

public struct JSONEncoding: ParameterEncodable {
    func encode(_ request: URLRequest, with parameters: Parameters?) throws -> URLRequest {
        var request = request
        guard let parameters else { return request }
        guard JSONSerialization.isValidJSONObject(parameters) else {
            throw NetworkError.parameterEnocdingFailed(.invalidJSON)
        }
        do {
            let data: Data = try JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = data
        }
        catch {
            throw NetworkError.parameterEnocdingFailed(.jsonEncodingFailed)
        }
        return request
    }
}
