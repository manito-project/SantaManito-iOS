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
    func asURLRequest() throws -> AnyPublisher<URLRequest, NetworkError.RequestError> {
        
        return Future<URLRequest, NetworkError> { promise in
            guard let url = URL(string: self.url) else {
                promise(.failure(.invalidURL(self.url)))
                return
            }
            
            var request = URLRequest(url: url)
            if let path { request.url?.append(path: path)}
            if let header { request.allHTTPHeaderFields = header }
            request.httpMethod = self.method.rawValue
            
            do {
                
            }
            
            
        }
        
        return try encoder.encode(request, with: parameters)
    }
}


import Foundation
import Combine


            // HTTP 메서드 설정
            
            
            do {
                // 요청 인코딩
                let encodedRequest = try self.encoder.encode(request, with: self.parameters)
                promise(.success(encodedRequest)) // 인코딩 성공 시 요청 반환
            } catch {
                promise(.failure(.encodingFailed)) // 인코딩 실패 시 에러 반환
            }
        }
        .eraseToAnyPublisher() // AnyPublisher로 변환하여 반환
    }
}
