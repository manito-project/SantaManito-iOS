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
    var encoder: ParameterEncodable? { get }
    
    func asURLRequest() -> AnyPublisher<URLRequest, SMNetworkError.RequestError>
}



extension URLRequestTargetType {
    func asURLRequest() -> AnyPublisher<URLRequest, SMNetworkError.RequestError> {
        guard let url = URL(string: self.url) else {
            return Fail(error: .invalidURL(self.url)).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        
        if let path = self.path { request.url?.append(path: path) }
        if let headers = self.headers { request.allHTTPHeaderFields = headers }
        
        request.httpMethod = self.method.rawValue

        if let encoder = self.encoder {
            return encoder.encode(request, with: self.parameters)
                .mapError { encodedErr in .parameterEncodingFailed(encodedErr) }
                .eraseToAnyPublisher()
        } else {
            return Just(request)
                .setFailureType(to: SMNetworkError.RequestError.self)
                .eraseToAnyPublisher()
        }
    }

}
