//
//  BaseService.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/28/24.
//

import Foundation
import Combine

class RequestHandler {
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        // TODO: Logging 추가
        // TODO: Interceptor 추가
        return URLSession(configuration: configuration)
    }()
    
    func executeRequest<T: URLRequestConfigurable>(for target: T) throws -> AnyPublisher<NetworkResponse, NetworkError> {
        let request = try target.asURLRequest() // 요청 생성
        
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.Response.unhandled(error: nil)
                }
                return NetworkResponse(data: data, response: httpResponse, error: nil)
            }
            .mapError { error in
                return NetworkError.requestFailed
            }
            .eraseToAnyPublisher() // AnyPublisher로 변환
    }
}


final class BaseService<Target: URLRequestConfigurable> {
    
    typealias API = Target
    
    private let requestHandler: RequestHandler
    
    init(requestHandler: RequestHandler) {
        self.requestHandler = requestHandler
    }
    
    func request<T: Decodable>(_ target: API) -> AnyPublisher<T, NetworkError> {
        return fetchResponse(with: target)
            .tryMap { response in
                // 응답을 유효성 검증
                try self.validate(response: response)
                return response.data! // 유효성 검증 통과 시, 데이터를 반환
            }
            .mapError { error in
                // 일반적인 Swift 에러를 NetworkError로 변환
                return error as? NetworkError ?? NetworkError.invalidRequest
            }
            .decode(type: T.self, decoder: JSONDecoder()) // 데이터를 디코딩
            .mapError { error in
                // 디코딩 에러도 NetworkError로 변환
                return error as? NetworkError ?? NetworkError.decodingFailed
            }
            .eraseToAnyPublisher() // AnyPublisher로 변환하여 반환
    }
    
    // Combine 기반의 네트워크 응답 처리
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
    
    // 응답 유효성 검사 메서드
    func validate(response: NetworkResponse) throws {
        guard let httpResponse = response.response as? HTTPURLResponse else {
            throw NetworkError.Response.unhandled(error: response.error)
        }
        
        guard httpResponse.isValidateStatus() else {
            // 유효하지 않은 HTTP 상태코드에 대한 에러 처리
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
public struct NetworkResponse {
    public let data: Data?
    public let response: URLResponse?
    public let error: Error?
    
    public init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
}
