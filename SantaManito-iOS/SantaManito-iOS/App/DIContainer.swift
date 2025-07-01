//
//  DIContainer.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/4/24.
//

import Foundation

typealias NavigationRoutableType = NavigationRoutable & ObservableObjectSettable
typealias WindowRoutableType = WindowRoutable & ObservableObjectSettable

final class DIContainer: ObservableObject {
    
    var service: ServiceType
    var navigationRouter: NavigationRoutableType
    var windowRouter: WindowRoutableType
    
    private init(
        service: ServiceType,
        navigationRouter: NavigationRoutableType = NavigationRouter(),
        windowRouter: WindowRoutableType = WindowRouter()
    ) {
        self.service = service
        self.navigationRouter = navigationRouter
        self.windowRouter = windowRouter
        
        navigationRouter.setObjectWillChange(objectWillChange)
        windowRouter.setObjectWillChange(objectWillChange)
    }
}

extension DIContainer {
    static let `default` = DIContainer(service: Service())
//    static let stub = DIContainer(service: StubService())
}
