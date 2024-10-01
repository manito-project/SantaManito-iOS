//
//  BaseService.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/28/24.
//

import Foundation
import Combine

final class BaseService<Target: URLRequestTargetType> {
    
    typealias API = Target
    
    private let requestHandler = RequestHandler.shared
    private let loggingHandler = NetworkLogger.shared
    
    func requestWithResult<T: Decodable>(_ target: API) -> AnyPublisher<T, NetworkError> {
        return fetchResponse(with: target)
            .tryMap { response in
                try self.validate(response: response)
                return response.data!
            }
            .mapError { $0 }
            .decode(type: GenericResponse<T>.self, decoder: JSONDecoder())
            .mapError { _ in  .decodingFailed(.failed) }
            .map { $0.data! }
            .print(loggingHandler.responseSuccess(target, result: $0))
            .eraseToAnyPublisher()
    }
    
    func requestWithNoResult(_ target: API) -> AnyPublisher<Void, NetworkError> {
        return fetchResponse(with: target)
            .tryMap { response in
                try self.validate(response: response)
                return response.data!
            }
            .mapError { $0 }
            .decode(type: GenericResponse<VoidResult>.self, decoder: JSONDecoder())
            .mapError { _ in  .decodingFailed(.failed) }
            .map { _ in () } //TODO: 이렇게 하면 안될거 같은데
            .eraseToAnyPublisher()
    }
}


extension BaseService {
    /// 네트워크 응답 처리 메소드
    private func fetchResponse(with target: API) -> AnyPublisher<NetworkResponse, NetworkError> {
        return requestHandler.executeRequest(for: target)
            .print(loggingHandler.requestLogging(target))
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
    
    /// 응답 유효성 검사 메서드
    func validate(response: NetworkResponse) throws {
        guard response.response.isValidateStatus() else {
            throw NetworkError.ResponseError.invalidStatusCode(code: response.response.statusCode)
        }
    }
}

// HTTP 상태코드 유효성 검사
extension HTTPURLResponse {
    func isValidateStatus() -> Bool {
        return (200...299).contains(self.statusCode)
    }
}


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
    
    func executeRequest<T: URLRequestTargetType>(for target: T) -> AnyPublisher<NetworkResponse, NetworkError> {
        return target.asURLRequest()
            .map { $0 }
            .mapError { .invalidRequest($0) }
            .flatMap { urlRequest in
                // URLRequest를 이용해 네트워크 요청 실행
                self.session.dataTaskPublisher(for: urlRequest)
                    .tryMap { data, response -> NetworkResponse in
                        guard let httpResponse = response as? HTTPURLResponse else {
                            throw NetworkError.ResponseError.unhandled(error: nil)
                        }
                        return NetworkResponse(data: data, response: httpResponse, error: nil)
                    }
                    .mapError { error -> NetworkError in
                        if let requestErr = error as? NetworkError.ResponseError {
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
