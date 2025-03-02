//
//  Encodable.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 3/3/25.
//

import Foundation

extension Encodable {
  func toDictionary() -> [String: Any]? {
    guard let object = try? JSONEncoder().encode(self) else { return nil }
    guard let dict = try? JSONSerialization.jsonObject(with: object) as? [String: Any] else { return nil }
    return dict
  }
}
