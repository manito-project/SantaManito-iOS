//
//  WindowRouter.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 10/16/24.
//

import Foundation
import Combine

protocol WindowRoutable {
    var destination: WindowDestination { get }
    func `switch`(to destination: WindowDestination)
}


class WindowRouter: WindowRoutable, ObservableObjectSettable {
    
    var objectWillChange: ObservableObjectPublisher?
    
    var destination: WindowDestination = .splash {
        didSet {
            objectWillChange?.send()
        }
    }
    
    func `switch`(to destination: WindowDestination) {
        self.destination = destination
    }
    
}

