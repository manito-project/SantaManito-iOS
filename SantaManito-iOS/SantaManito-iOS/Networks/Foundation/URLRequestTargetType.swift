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
    
    func asURLRequest() -> AnyPublisher<URLRequest, SMNetworkError.RequestError>
}

extension Task {
    func buildRequest(baseURL: URL, method: HTTPMethod, headers: [String: String]?) -> AnyPublisher<URLRequest, SMNetworkError.RequestError> {
        var request = URLRequest(url: baseURL)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        switch self {
        case .requestPlain:
            return Just(request)
                .setFailureType(to: SMNetworkError.RequestError.self)
                .eraseToAnyPublisher()
                
        case .requestParameters(let parameters):
            return URLEncoding().encode(request, with: parameters)
                .mapError { .parameterEncodingFailed($0) }
                .eraseToAnyPublisher()
                
        case .requestJSONEncodable(let encodable):
            return JSONEncoding().encode(request, with: encodable)
                .mapError { .parameterEncodingFailed($0) }
                .eraseToAnyPublisher()
        }
    }
}


extension URLRequestTargetType {
    func asURLRequest() -> AnyPublisher<URLRequest, SMNetworkError.RequestError> {
        guard let url = URL(string: self.url) else {
            return Fail(error: .invalidURL(self.url)).eraseToAnyPublisher()
        }

        var baseURL = url
        if let path = self.path { baseURL.appendPathComponent(path) }

        return task.buildRequest(baseURL: baseURL, method: self.method, headers: self.headers)
    }
}
