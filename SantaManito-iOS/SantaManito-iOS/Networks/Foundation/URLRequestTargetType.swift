//
//  URLRequestConfigurable.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/28/24.
//

import Foundation
import Combine

enum Task {
    case requestPlain
    case requestParameters(Parameters)
    case requestJSONEncodable(Encodable)
}
protocol URLRequestTargetType {
    var url: String { get }
    var path: String? { get }
    var method: HTTPMethod { get }
    var headers : [String : String]? { get }
    var task: Task { get }
    
    func asURLRequest() async throws -> URLRequest
}

extension Task {
    func buildRequest(
        baseURL: URL,
        method: HTTPMethod,
        headers: [String: String]?
    ) async throws -> URLRequest {
        var request = URLRequest(url: baseURL)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        switch self {
        case .requestPlain:
            return request
                
        case .requestParameters(let parameters):
            return try await encodeRequest(
                request, using: URLEncoding(), parameters: parameters
            )
                
        case .requestJSONEncodable(let encodable):
            return try await encodeRequest(
                request, using: JSONEncoding(), parameters: encodable
            )
        }
    }
    
    private func encodeRequest<E: ParameterEncodable>(
        _ request: URLRequest,
        using encoder: E,
        parameters: E.ParameterType
    ) async throws -> URLRequest {
        do {
            return try await encoder.encode(request, with: parameters)
        } catch let error as SMNetworkError.ParameterEncoding {
            throw SMNetworkError.RequestError.parameterEncodingFailed(error)
        }
    }
}


extension URLRequestTargetType {
    func asURLRequest() async throws -> URLRequest {
        guard let url = URL(string: self.url) else {
            throw SMNetworkError.RequestError.invalidURL(self.url)
        }

        var baseURL = url
        if let path = self.path { baseURL.appendPathComponent(path) }

        return try await task.buildRequest(baseURL: baseURL, method: self.method, headers: self.headers)
    }
}
