//
//  LoggerPlugin.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 10/1/24.
//


import UIKit

final class NetworkLogger {
    
    func requestLogging(_ endpoint: URLRequestTargetType) -> String {
              """
                  ================== 📤 Request ===================>
                  📝 URL: \(endpoint.url + (endpoint.path ?? ""))
                  📝 HTTP Method: \(endpoint.method.rawValue)
                  📝 Header: \(endpoint.headers)
                  📝 Parameters: \(endpoint.parameters) ?? [:])
                  ================================
              """
    }
    
    func responseSuccess(_ endpoint: any URLRequestTargetType, result response: NetworkResponse) {
        print("""
                  ======================== 📥 Response <========================
                  ========================= ✅ Success =========================
                  ✌🏻 URL: \(endpoint.url + (endpoint.path ?? ""))
                  ✌🏻 Header: \(endpoint.headers)
                  ✌🏻 Success_Data: \(String(describing: response.data))
                  ==============================================================
              """)
    }
    
    func responseError(_ endpoint: any URLRequestTargetType, statusCode: Int , result error: NetworkError) {
        print("""
                  ======================== 📥 Response <========================
                  ========================= ❌ Error.. =========================
                  ❗️ URL: \(endpoint.url + (endpoint.path ?? ""))
                  ❗️ Header: \(endpoint.headers)
                  ❗️ StatusCode: \(statusCode)
                  ❗️ Error_Data: \(error)
                  ==============================================================
              """)
    }
}


