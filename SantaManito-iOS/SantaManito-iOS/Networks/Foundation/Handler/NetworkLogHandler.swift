//
//  NetworkLogHandler.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 10/1/24.
//


import UIKit

final class NetworkLogHandler {
    
    static let shared = NetworkLogHandler()
    
    private init() {}
    
    func requestLogging(_ endpoint: URLRequestTargetType) {
        print("""
                  ================== 📤 Request ===================>
                  📝 URL: \(endpoint.url + (endpoint.path ?? ""))
                  📝 HTTP Method: \(endpoint.method.rawValue)
                  📝 Header: \(endpoint.headers!)
                  📝 Parameters: \(endpoint.parameters!) ?? [:])
                  ================================
              """)
    }
    
    func responseSuccess(_ endpoint: any URLRequestTargetType, result response: NetworkResponse) {
        print("""
                  ======================== 📥 Response <========================
                  ========================= ✅ Success =========================
                  ✌🏻 URL: \(endpoint.url + (endpoint.path ?? ""))
                  ✌🏻 Header: \(endpoint.headers!)
                  ✌🏻 Success_Data: \(String(describing: response.data))
                  ==============================================================
              """)
    }
    
    func responseError(_ endpoint: any URLRequestTargetType, result error: SMNetworkError) {
        
        print("""
                  ======================== 📥 Response <========================
                  ========================= ❌ Error.. =========================
                  ❗️ Error Type: \(error.description)
                  ❗️ URL: \(endpoint.url + (endpoint.path ?? ""))
                  ❗️ Header: \(endpoint.headers!)
                  ❗️ Error_Data: \(error.localizedDescription)
                  ==============================================================
              """)
    }
}


