//
//  DIContainer.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/4/24.
//

import Foundation

typealias NavigationRoutableType = NavigationRoutable & ObservableObjectSettable

class DIContainer: ObservableObject {
    
    var service: ServiceType
    var navigationRouter: NavigationRoutable & ObservableObjectSettable
    
    init(
        service: ServiceType,
        navigationRouter: NavigationRoutable & ObservableObjectSettable = NavigationRouter()
    ) {
        self.service = service
        self.navigationRouter = navigationRouter
        
        navigationRouter.setObjectWillChange(objectWillChange)
    }
}
