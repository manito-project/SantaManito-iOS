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
    private let loggingHandler = NetworkLogHandler.shared
    private let errorHandler = ErrorHandler.shared
    
    func requestWithResult<T: Decodable>(_ target: API) -> AnyPublisher<T, SMNetworkError> {
        return fetchResponse(with: target)
            .flatMap { response in
                self.validate(response: response)
                    .map { _ in response.data! }
                    .mapError { [weak self] error in
                        guard let self else { return .unknown}
                        return self.errorHandler.handleError(target, error: error)
                    }
            }
            .flatMap { self.decode(data: $0, target: target) }
            .eraseToAnyPublisher()
    }
    
    func requestWithNoResult(_ target: API) -> AnyPublisher<Void, SMNetworkError> {
        return fetchResponse(with: target)
            .flatMap { response -> AnyPublisher<Data, SMNetworkError> in
                self.validate(response: response) // validate 연결
                    .map { _ in response.data! } // 성공 시 data 반환
                    .eraseToAnyPublisher()
            }
            .mapError { [weak self] error in
                guard let self = self else { return .unknown }
                return self.errorHandler.handleError(target, error: error)
            }
            .flatMap { data -> AnyPublisher<VoidResult, SMNetworkError> in
                self.decode(data: data, target: target)
            }
            .map { _ in () }
            .eraseToAnyPublisher()
    }
}


extension BaseService {
    /// 네트워크 응답 처리 메소드
    private func fetchResponse(with target: API) -> AnyPublisher<NetworkResponse, SMNetworkError> {
        return requestHandler.executeRequest(for: target)
            .handleEvents(receiveSubscription:  { [weak self] _ in
                self?.loggingHandler.requestLogging(target)
            }, receiveOutput:  { [weak self] response in
                self?.loggingHandler.responseSuccess(target, result: response)
            })
            .mapError { [weak self] error in
                self?.loggingHandler.responseError(target, result: error)
                return error
            }
            .eraseToAnyPublisher()
    }
    
    /// 응답 유효성 검사 메서드
    private func validate(response: NetworkResponse) -> AnyPublisher<Void, SMNetworkError> {
        guard response.response.isValidateStatus() else {
            return Fail(error: SMNetworkError.invalidResponse(.invalidStatusCode(code: response.response.statusCode)))
                .eraseToAnyPublisher()
        }
        return Just(()).setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
    }
    
    /// 디코딩 메소드
    private func decode<T: Decodable>(data: Data, target: API) -> AnyPublisher<T, SMNetworkError> {
        return Just(data)
            .decode(type: GenericResponse<T>.self, decoder: JSONDecoder())
            .mapError { [weak self] error in
                guard let self else { return .unknown}
                return self.errorHandler.handleError(target, error: .decodingFailed(.failed))
            }
            .map { $0.data! }
            .eraseToAnyPublisher()
    }
    
}

// HTTP 상태코드 유효성 검사
extension HTTPURLResponse {
    func isValidateStatus() -> Bool {
        return (200...299).contains(self.statusCode)
    }
}
