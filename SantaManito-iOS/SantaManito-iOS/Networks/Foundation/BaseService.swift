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
    
    
    func request(
        _ target: API
    ) async throws -> Void {
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
    /// 네트워크 응답 처리 메소드
    private func fetchResponse(with target: API) async throws -> NetworkResponse {
        NetworkLogHandler.requestLogging(target)
        do {
            let response = try await requestHandler.executeRequest(for: target)
            await NetworkLogHandler.responseSuccess(target, result: response)
            return response
        } catch let error as SMNetworkError {
            NetworkLogHandler.responseError(target, result: error)
            throw error
        }
    }
    
    private func validate(response: NetworkResponse) async throws {
        guard response.response.isValidateStatus() else {
            guard let data = response.data else {
                throw SMNetworkError.invalidResponse(
                    .invalidStatusCode(code: response.response.statusCode)
                )
            }
            
            if let errorResponse = try? DecodeHandler.shared.decode(ErrorResponse.self, from: data) {
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
    
    @discardableResult
    private func decode<T: Decodable>(data: Data) async throws -> T {
        do { return try DecodeHandler.shared.decode(T.self, from: data) }
        catch { throw SMNetworkError.DecodeError.failed }
    }
    
}

// HTTP 상태코드 유효성 검사
extension HTTPURLResponse {
    func isValidateStatus() -> Bool {
        return (200...299).contains(self.statusCode)
    }
}
