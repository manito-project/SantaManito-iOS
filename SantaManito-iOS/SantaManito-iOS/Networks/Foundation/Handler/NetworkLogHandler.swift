//
//  NetworkLogHandler.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 10/1/24.
//

import Foundation

struct NetworkLogHandler {
    
    // 네트워크 요청 로깅 함수
    static func requestLogging(_ endpoint: URLRequestTargetType) {
        let url = endpoint.url + (endpoint.path ?? "")
        let method = endpoint.method.rawValue
        let headers = endpoint.headers ?? [:]
        let parameters = endpoint.task.self
        
        print("""
            ================== 📤 Request ===================>
            📝 URL: \(url)
            📝 HTTP Method: \(method)
            📝 Header: \(headers)
            📝 Parameters: \(parameters)
            ================================
            """)
    }
    
    // 성공적인 응답 로깅 함수
    static func responseSuccess(_ endpoint: any URLRequestTargetType, result response: NetworkResponse) async {
        let url = endpoint.url + (endpoint.path ?? "")
        let headers = endpoint.headers ?? [:]
        let responseData = String(data: response.data ?? Data(), encoding: .utf8) ?? "No data"
        
        print("""
            ======================== 📥 Response <========================
            ========================= ✅ Success =========================
            ✌🏻 URL: \(url)
            ✌🏻 Header: \(headers)
            ✌🏻 Success Data: \(responseData)
            ==============================================================
            """)
    }
    
    // 에러 응답 로깅 함수
    static func responseError(_ endpoint: any URLRequestTargetType, result error: Error)  {
        let networkError = error as? SMNetworkError ?? SMNetworkError.unknown(error)
        
        let url = endpoint.url + (endpoint.path ?? "")
        let headers = endpoint.headers ?? [:]
        
        print("""
            ======================== 📥 Response <========================
            ========================= ❌ Error ==========================
            ❗️ Error Type: \(networkError.description)
            ❗️ URL: \(url)
            ❗️ Header: \(headers)
            ❗️ Error Data: \(error.localizedDescription)
            ==============================================================
            """)
    }
}
