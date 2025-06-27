//
//  ParameterEncoding.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/28/24.
//

import Foundation
import Combine

protocol ParameterEncodable {}

extension ParameterEncodable {
    func checkValidURLData(
        _ parameters: Parameters?,
        _ url: URL?
    ) throws -> (Parameters, URL) {
        guard let parameters else { throw SMNetworkError.ParameterEncoding.emptyParameters }
        guard let url else { throw SMNetworkError.ParameterEncoding.missingURL }
        return (parameters, url)
    }
    
    func checkValidURLData(
        _ parameters: Encodable?,
        _ url: URL?
    ) throws -> (Encodable, URL) {
        guard let parameters else { throw SMNetworkError.ParameterEncoding.emptyParameters }
        guard let url else { throw SMNetworkError.ParameterEncoding.missingURL }
        return (parameters, url)
    }
}

public struct URLEncoding: ParameterEncodable {
    func encode(
        _ request: URLRequest,
        with parameters: Parameters?
    ) async throws -> URLRequest {
        var request = request
        let (validParameters, url) = try checkValidURLData(parameters, request.url)
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            urlComponents.queryItems = validParameters.compactMap { key, value in
                URLQueryItem(name: key, value: "\(value)")
            }
            request.url = urlComponents.url
        }
        return request
    }
}


public struct JSONEncoding: ParameterEncodable {
    func encode(
        _ request: URLRequest,
        with parameters: Encodable?
    ) async throws -> URLRequest {
        var request = request
        
        let encoder = JSONEncoder()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0) // UTC 기준으로 인코딩
        encoder.dateEncodingStrategy = .formatted(formatter)
        
        let (validParameters, _) = try checkValidURLData(parameters, request.url)
        do {
            let data = try encoder.encode(validParameters)
            request.httpBody = data
            return request
        } catch {
            throw SMNetworkError.RequestError.parameterEncodingFailed(.jsonEncodingFailed)
        }
    }
}

