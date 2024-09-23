//
//  Util.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/4/24.
//

import Combine

protocol ObservableObjectSettable: AnyObject {
  var objectWillChange: ObservableObjectPublisher? { get set }
  func setObjectWillChange(_ objectWillChange: ObservableObjectPublisher?)
}

extension ObservableObjectSettable {
  func setObjectWillChange(_ objectWillChange: ObservableObjectPublisher?) {
    self.objectWillChange = objectWillChange
  }
}
