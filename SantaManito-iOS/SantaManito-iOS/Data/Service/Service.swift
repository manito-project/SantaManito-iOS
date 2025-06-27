//
//  Service.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/4/24.
//

import Foundation

protocol ServiceType {
    var appService: AppServiceType { get }
    var authService: AuthenticationServiceType { get }
    var userService: UserServiceType { get set }
    var roomService: RoomServiceType { get }
    var remoteConfigService: RemoteConfigServiceType { get }
}

final class Service: ServiceType {
    var appService: AppServiceType = AppService()
    var authService: AuthenticationServiceType = AuthenticationService()
    var userService: UserServiceType = UserService()
    var roomService: RoomServiceType = RoomService()
    var remoteConfigService: RemoteConfigServiceType = FirebaseRemoteConfigService.shared
}


//class StubService: ServiceType {
//    
//    var appService: AppServiceType = StubAppService()
//    var authService: AuthenticationServiceType = StubAuthenticationService()
//    var userService: UserServiceType = StubUserService()
//    var roomService: RoomServiceType = StubRoomService()
//    var remoteConfigService: RemoteConfigServiceType = StubRemoteConfigService()
//    
//}
