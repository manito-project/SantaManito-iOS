//
//  NetworkResponse.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/30/24.
//

import Foundation

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
