//
//  RequestHandler.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 10/2/24.
//

import Foundation
import Combine

class RequestHandler {
    
    static let shared = RequestHandler()
    
    private init() {}
    
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        // TODO: Logging 추가
        // TODO: Interceptor 추가
        return URLSession(configuration: configuration)
    }()
    
    func executeRequest<T: URLRequestTargetType>(for target: T) -> AnyPublisher<NetworkResponse, SMNetworkError> {
        return target.asURLRequest()
            .map { $0 }
            .mapError { error in
                NetworkLogHandler.shared.responseError(target, result: .invalidRequest(error))
                return .invalidRequest(error)
            }
            .flatMap { urlRequest in
                // URLRequest를 이용해 네트워크 요청 실행
                self.session.dataTaskPublisher(for: urlRequest)
                    .tryMap { data, response -> NetworkResponse in
                        guard let httpResponse = response as? HTTPURLResponse else {
                            throw SMNetworkError.ResponseError.unhandled
                        }
                        return NetworkResponse(data: data, response: httpResponse, error: nil)
                    }
                    .mapError { error -> SMNetworkError in
                        if let requestErr = error as? SMNetworkError.ResponseError {
                            return .invalidResponse(requestErr)
                        } else {
                            return .unknown
                        }
                    }
                    .eraseToAnyPublisher()
            }
        
            .eraseToAnyPublisher()
    }
}

