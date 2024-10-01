//
//  URLRequestConfigurable.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/28/24.
//

import Foundation
import Combine

protocol URLRequestTargetType {
    var url: String { get }
    var path: String? { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var headers : [String : String]? { get }
    var encoder: ParameterEncodable { get }
    
    func asURLRequest() -> AnyPublisher<URLRequest, NetworkError.RequestError>
}



extension URLRequestTargetType {
    func asURLRequest() -> AnyPublisher<URLRequest, NetworkError.RequestError> {
        guard let url = URL(string: self.url) else {
            return Fail(error: NetworkError.RequestError.invalidURL(self.url)).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        if let path {
            request.url?.append(path: path)
        }
        if let headers {
            request.allHTTPHeaderFields = headers
        }
        request.httpMethod = self.method.rawValue

        return self.encoder.encode(request, with: self.parameters)
            .mapError { _ in NetworkError.RequestError.invalidRequest }
            .eraseToAnyPublisher()
    }
}
