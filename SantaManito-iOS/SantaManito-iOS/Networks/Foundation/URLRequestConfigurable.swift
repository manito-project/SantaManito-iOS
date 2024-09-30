//
//  URLRequestConfigurable.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/28/24.
//

import Foundation
import Combine

protocol URLRequestConfigurable {
    var url: String { get }
    var path: String? { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var header : [String : String]? { get }
    var encoder: ParameterEncodable { get }
    
    func asURLRequest() throws -> URLRequest
}


extension URLRequestConfigurable {
    func asURLRequest() -> AnyPublisher<URLRequest, NetworkError.RequestError> {
        guard let url = URL(string: self.url) else {
            return Fail(error: .invalidURL(self.url)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        if let path { request.url?.append(path: path) }
        if let header { request.allHTTPHeaderFields = header }
        request.httpMethod = self.method.rawValue
        
        return self.encoder.encode(request, with: self.parameters)
            .mapError { _ in NetworkError.RequestError.invalidRequest }  // NetworkError로 변환
            .eraseToAnyPublisher()
    }
}
