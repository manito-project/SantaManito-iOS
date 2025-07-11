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
        // TODO: Interceptor 추가
        return URLSession(configuration: configuration)
    }()
    
    private func buildRequest<T: URLRequestTargetType>(for target: T) async throws -> URLRequest {
        do { return try await target.asURLRequest() }
        catch let error as SMNetworkError.RequestError {
            throw ErrorHandler.handleError(target, error: .invalidRequest(error))
        }
    }
    
    func executeRequest<T: URLRequestTargetType>(for target: T) async throws -> NetworkResponse {
        let urlRequest = try await target.asURLRequest()
        do {
            let (data, response) = try await session.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw SMNetworkError.ResponseError.unhandled
            }
            return NetworkResponse(data: data, response: httpResponse, error: nil)
        } catch let error as SMNetworkError.ResponseError {
            throw SMNetworkError.invalidResponse(error)
        } catch {
            throw SMNetworkError.unknown(error)
        }
    }
}

