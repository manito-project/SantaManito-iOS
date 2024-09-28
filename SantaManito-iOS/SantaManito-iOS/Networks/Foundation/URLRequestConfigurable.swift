//
//  URLRequestConfigurable.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/28/24.
//

import Foundation

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
    func asURLRequest() throws -> URLRequest {
        
        guard let url = URL(string: url) else { throw NetworkError.invalidURL(url) }
        var request = URLRequest(url: url)
        
        if let path { request.url?.append(path: path)}
        if let header { request.allHTTPHeaderFields = header }
        request.httpMethod = method.rawValue
        
        return try encoder.encode(request, with: parameters)
    }
}
