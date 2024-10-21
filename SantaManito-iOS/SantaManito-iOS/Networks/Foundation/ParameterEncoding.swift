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
    ) -> AnyPublisher<(Parameters, URL), SMNetworkError.ParameterEncoding> {
        guard let parameters else { return Fail(error: .emptyParameters).eraseToAnyPublisher() }
        guard let url else { return Fail(error: .missingURL).eraseToAnyPublisher() }
        
        return Just((parameters, url))
            .setFailureType(to: SMNetworkError.ParameterEncoding.self)
            .eraseToAnyPublisher()
    }
    
    func checkValidURLData(
        _ parameters: Encodable?,
        _ url: URL?
    ) -> AnyPublisher<(Encodable, URL), SMNetworkError.ParameterEncoding> {
        guard let parameters else { return Fail(error: .emptyParameters).eraseToAnyPublisher() }
        guard let url else { return Fail(error: .missingURL).eraseToAnyPublisher() }
        
        //        TODO: 2024.10.09 수정. 확인 했다면 주석 지워도됨. to 히디 from 석우
        //         let data = try JSONSerialization.data(withJSONObject: parameters)
        //        guard JSONSerialization.isValidJSONObject(parameters) else {
        //            return Fail(error: .invalidJSON).eraseToAnyPublisher()
        //        }
        
        return Just((parameters, url))
            .setFailureType(to: SMNetworkError.ParameterEncoding.self)
            .eraseToAnyPublisher()
    }
}

public struct URLEncoding: ParameterEncodable {
    func encode(_ request: URLRequest, with parameters: Parameters?) -> AnyPublisher<URLRequest, SMNetworkError.ParameterEncoding> {
        var request = request
        
        return checkValidURLData(parameters, request.url)
            .map { parameters, url -> URLRequest in
                if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
                    urlComponents.queryItems = parameters.compactMap { key, value in
                        URLQueryItem(name: key, value: "\(value)")
                    }
                    request.url = urlComponents.url
                }
                return request
            }
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
}


public struct JSONEncoding: ParameterEncodable {
    func encode(_ request: URLRequest, with parameters: Encodable?) -> AnyPublisher<URLRequest, SMNetworkError.ParameterEncoding> {
        var request = request
        let encoder = JSONEncoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0) // UTC 기준으로 인코딩
        encoder.dateEncodingStrategy = .formatted(formatter)
        
        return checkValidURLData(parameters, request.url)
            .tryMap { parameters, _ -> URLRequest in
                do {
                    let data = try encoder.encode(parameters)
                    request.httpBody = data
//                    let s = try JSONSerialization.jsonObject(with: data)
//                    print(s)
                    return request
                } catch {
                    throw SMNetworkError.invalidRequest(.parameterEncodingFailed(.jsonEncodingFailed))
                }
            }
            .mapError { $0 as! SMNetworkError.ParameterEncoding } //TODO: 예외 상황이 없는거 같아서..
            .eraseToAnyPublisher()
    }
}
