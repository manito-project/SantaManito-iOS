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
        } catch let error as SMNetworkError {
            throw ErrorHandler.handleError(target, error: error)
        }
    }
}


extension BaseService {
    /// 네트워크 응답 처리 메소드
    private func fetchResponse(with target: API) async throws -> NetworkResponse {
        await NetworkLogHandler.requestLogging(target)
        do {
            let response = try await requestHandler.executeRequest(for: target)
            await NetworkLogHandler.responseSuccess(target, result: response)
            return response
        } catch let error as SMNetworkError {
            throw ErrorHandler.handleError(target, error: error)
        }
    }
    
    private func validate(response: NetworkResponse) async throws {
        guard response.response.isValidateStatus() else {
            guard let data = response.data else {
                throw SMNetworkError.invalidResponse(
                    .invalidStatusCode(code: response.response.statusCode)
                )
            }
            
            if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
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
        let decoder = makeDecoder()
        do {
            let wrapper = try decoder.decode(GenericResponse<T>.self, from: data)
            guard let decodedData = wrapper.data else { throw SMNetworkError.DecodeError.dataIsNil }
            return decodedData
        } catch { throw SMNetworkError.DecodeError.failed }
    }
    
    
    private func makeDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }
    
}

// HTTP 상태코드 유효성 검사
extension HTTPURLResponse {
    func isValidateStatus() -> Bool {
        return (200...299).contains(self.statusCode)
    }
}
