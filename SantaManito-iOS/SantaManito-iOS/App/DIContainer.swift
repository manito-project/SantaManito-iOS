//
//  DIContainer.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/4/24.
//

import Foundation

class DIContainer: ObservableObject {
  
  var service: ServiceType
  
  init(
    service: ServiceType
  ) {
    self.service = service
  }
}
