//
//  Service.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/4/24.
//

import Foundation

protocol ServiceType {
    var authService: AuthenticationServiceType { get set }
    var userService: UserServiceType { get set }
    var roomService: RoomServiceType { get }
    var editRoomService: EditRoomServiceType { get }
    var enterRoomService: EnterRoomServiceType { get }
    var matchRoomService: MatchRoomServiceType { get }
    var pushNotificationService: PushNotificationServiceType { get set }
}

//class Service: ServiceType {
//
//  var authService: AuthenticationServiceType
//  var userService: UserServiceType
//  var pushNotificationService: PushNotificationServiceType
//
//  init() {
//    self.authService = AuthenticationService()
//    self.userService = UserService()
//    self.pushNotificationService = PushNotificationService()
//  }
//}


class StubService: ServiceType {
    
    var authService: AuthenticationServiceType = StubAuthenticationService()
    var userService: UserServiceType = StubUserService()
    var roomService: RoomServiceType = StubRoomService()
    var editRoomService: EditRoomServiceType = StubEditRoomService()
    var enterRoomService: EnterRoomServiceType = StubEnterRoomService()
    var matchRoomService: MatchRoomServiceType = StubMatchRoomService()
    var pushNotificationService: PushNotificationServiceType = StubPushNotificationService()
    
}
