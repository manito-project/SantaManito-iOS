//
//  DIContainer.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/4/24.
//

import Foundation

typealias NavigationRoutableType = NavigationRoutable & ObservableObjectSettable

final class DIContainer: ObservableObject {
    
    var service: ServiceType
    var navigationRouter: NavigationRoutableType
    
    private init(
        service: ServiceType,
        navigationRouter: NavigationRoutableType = NavigationRouter()
    ) {
        self.service = service
        self.navigationRouter = navigationRouter
        
        navigationRouter.setObjectWillChange(objectWillChange)
    }
}

extension DIContainer {
    static let `default` = DIContainer(service: StubService()) // TODO: 실제 service로 변경 필요
    static let stub = DIContainer(service: StubService())
}
