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
    
    private let requestHandler: RequestHandler
    
    init(requestHandler: RequestHandler) {
        self.requestHandler = requestHandler
    }
    
    func request<T: Decodable>(_ target: API) -> AnyPublisher<T, NetworkError> {
        return fetchResponse(with: target)
            .tryMap { response in
                try self.validate(response: response)
                return response.data! // 유효성 검증 통과 시, 데이터를 반환
            }
            .mapError { _ in NetworkError.invalidRequest}
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { _ in  .decodingFailed } // 디코딩 에러도 NetworkError로 변환
            .eraseToAnyPublisher() // AnyPublisher로 변환하여 반환
    }
    
    func requestWithNoResult(_ target: API) -> AnyPublisher<Void, NetworkError> {
        return fetchResponse(with: target)
            .tryMap { response in
                try self.validate(response: response)
            }
            .mapError { _ in NetworkError.invalidRequest}
            .eraseToAnyPublisher() // AnyPublisher로 변환하여 반환
    }
}


extension BaseService {
    /// 네트워크 응답 처리 메소드
    private func fetchResponse(with target: API) -> AnyPublisher<NetworkResponse, NetworkError> {
        do {
            let request = try requestHandler.executeRequest(for: target)
            return request
                .mapError { _ in NetworkError.invalidRequest }
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: .invalidRequest).eraseToAnyPublisher()
        }
    }
    
    /// 응답 유효성 검사 메서드
    func validate(response: NetworkResponse) throws {
        guard let httpResponse = response.response as? HTTPURLResponse else {
            throw NetworkError.Response.unhandled(error: response.error)
        }
        
        guard httpResponse.isValidateStatus() else {
            throw NetworkError.Response.invalidStatusCode(code: httpResponse.statusCode)
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
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        // TODO: Logging 추가
        // TODO: Interceptor 추가
        return URLSession(configuration: configuration)
    }()
    
    func executeRequest<T: URLRequestTargetType>(for target: T) throws -> AnyPublisher<NetworkResponse, NetworkError> {
        let endPoint = try target.asURLRequest()
        
        return session.dataTaskPublisher(for: endPoint)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.Response.unhandled(error: nil)
                }
                return NetworkResponse(data: data, response: httpResponse, error: nil)
            }
            .mapError { error in
                return NetworkError.requestFailed(error as! NetworkError.RequestError) // 요청값이 오지 않는 경우
            }
            .eraseToAnyPublisher()
    }
}
