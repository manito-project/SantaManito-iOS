//
//  DecodingHandler.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 7/4/25.
//

import Foundation

final class DecodeHandler {
    static let shared = DecodeHandler()

    private let decoder: JSONDecoder

    private init() {
        decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        decoder.dateDecodingStrategy = .formatted(formatter)
    }

    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        let wrapper = try decoder.decode(GenericResponse<T>.self, from: data)
        guard let decoded = wrapper.data else {
            throw SMNetworkError.DecodeError.dataIsNil
        }
        return decoded
    }
}
