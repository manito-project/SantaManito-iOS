//
//  BaseService.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/28/24.
//

import Foundation

final class BaseService<Target: URLRequestTargetType> {
    typealias API = Target
    
    private let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        // TODO: Interceptor 추가
        return URLSession(configuration: configuration)
    }()
    
    func request(_ target: API) async throws -> Void {
        _ = try await request(target, as: VoidResult.self)
    }

    func request<T: Decodable>(
        _ target: API,
        as type: T.Type = T.self
    ) async throws -> T {
        do {
            let response = try await fetchResponse(with: target)
            try await validate(response: response)
            guard let data = response.data else {
                throw SMNetworkError.invalidResponse(.missingData)
            }
            return try await decode(data: data)
        } catch {
            NetworkLogHandler.responseError(target, result: error)
            throw error
        }
    }
}

extension BaseService {
    /// 네트워크 요청 처리 메소드
    private func executeRequest<T: URLRequestTargetType>(for target: T) async throws -> NetworkResponse {
        let urlRequest = try await target.asURLRequest()
        do {
            let (data, response) = try await session.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw SMNetworkError.ResponseError.unhandled
            }
            return NetworkResponse(data: data, response: httpResponse, error: nil)
        } catch {
            NetworkLogHandler.responseError(target, result: error)
            throw error
        }
    }
    
    /// 네트워크 응답 처리 메소드
    private func fetchResponse(with target: API) async throws -> NetworkResponse {
        NetworkLogHandler.requestLogging(target)
        do {
            let response = try await executeRequest(for: target)
            await NetworkLogHandler.responseSuccess(target, result: response)
            return response
        } catch let error as SMNetworkError {
            NetworkLogHandler.responseError(target, result: error)
            throw error
        }
    }
    
    /// 응답 유효성 판단 메소드
    private func validate(response: NetworkResponse) async throws {
        guard response.response.isValidateStatus() else {
            guard let data = response.data else {
                throw SMNetworkError.invalidResponse(
                    .invalidStatusCode(code: response.response.statusCode)
                )
            }
            
            if let errorResponse = try? DecodeHandler.decode(ErrorResponse.self, from: data) {
                throw SMNetworkError.invalidResponse(
                    .invalidStatusCode(code: errorResponse.statusCode, data: errorResponse.data)
                )
            } else {
                throw SMNetworkError.invalidResponse(
                    .invalidStatusCode(code: response.response.statusCode)
                )
            }
        }
        
    }
    
    /// 디코딩 메소드
    @discardableResult
    private func decode<T: Decodable>(data: Data) async throws -> T {
        do { return try DecodeHandler.decode(T.self, from: data) }
        catch { throw SMNetworkError.DecodeError.failed }
    }
    
}

// HTTP 상태코드 유효성 검사
extension HTTPURLResponse {
    func isValidateStatus() -> Bool {
        return (200...299).contains(self.statusCode)
    }
}
