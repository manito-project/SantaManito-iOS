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
    
    func requestWithResult<T: Decodable>(_ target: API, _ responseType: T.Type) -> AnyPublisher<T, SMNetworkError> {
        return fetchResponse(with: target)
            .flatMap { response in
                self.validate(response: response)
                    .map { _ in response.data! }
                    .mapError { ErrorHandler.handleError(target, error: $0) }
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
            .mapError { ErrorHandler.handleError(target, error: $0) }
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
            .handleEvents(receiveSubscription:  {  _ in
                NetworkLogHandler.requestLogging(target)
            }, receiveOutput:  {  response in
                NetworkLogHandler.responseSuccess(target, result: response)
            })
            .mapError { ErrorHandler.handleError(target, error: $0) }
            .eraseToAnyPublisher()
    }
    
    /// 응답 유효성 검사 메서드
    private func validate(response: NetworkResponse) -> AnyPublisher<Void, SMNetworkError> {
        guard response.response.isValidateStatus() else {
            guard let data = response.data else {
                return Fail(error: SMNetworkError.invalidResponse(.invalidStatusCode(code: response.response.statusCode)))
                    .eraseToAnyPublisher()
            }
            
            return Just(data)
                .decode(type: ErrorResponse.self, decoder: JSONDecoder())
                .mapError { _ in SMNetworkError.invalidResponse(.invalidStatusCode(code: response.response.statusCode)) }
                .flatMap { response in
                    Fail(error: SMNetworkError.invalidResponse(.invalidStatusCode(
                                code: response.statusCode,
                                data: response.data
                            )
                        )
                    ).eraseToAnyPublisher()
                }
                .eraseToAnyPublisher()
        }
        return Just(()).setFailureType(to: SMNetworkError.self).eraseToAnyPublisher()
    }
    
    /// 디코딩 메소드
    private func decode<T: Decodable>(data: Data, target: API) -> AnyPublisher<T, SMNetworkError> {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: -1 * 9 * 60 * 60) // 한국 시간 (KST) UTC+9로 설정
        // - 를 한 이유는 서버엔 UTC+9기준으로 저장되지만
        // iOS에서 Date는 UTC 기준으로 설정되기에
        // 서버의 UTC + 9 를 UTC 기준으로 변환 후
        // iOS 내 모든 Date는 UTC 타임을 기준으로 설정하게 한다.
        // 단, Date의 timeZone은 Asia/Seoul로 설정하여 유저에겐 UTC +9 시간을 보여준다.
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        return Just(data)
            .decode(type: GenericResponse<T>.self, decoder: decoder)
            .mapError { _ in ErrorHandler.handleError(target, error: .decodingFailed(.failed)) }
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
