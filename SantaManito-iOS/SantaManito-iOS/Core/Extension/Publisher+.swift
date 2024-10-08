//
//  Publisher+.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 10/5/24.
//

import Foundation
import Combine
import SwiftUI

extension Publisher {

    func assignLoading<Root>(to keyPath: ReferenceWritableKeyPath<Root, Bool>, on object: Root) -> Publishers.HandleEvents<Self> {
        handleEvents(
            receiveCompletion: { _ in object[keyPath: keyPath] = false },
            receiveRequest: { _ in object[keyPath: keyPath] = true }
        )
    }
}
