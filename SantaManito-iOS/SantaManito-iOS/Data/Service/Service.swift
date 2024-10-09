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
    var editRoomService: EditRoomServiceType { get }
    var matchRoomService: MatchRoomServiceType { get }
    var remoteConfigService: RemoteConfigServiceType { get }
}

final class Service: ServiceType {
    var appService: AppServiceType = AppService()
    var authService: AuthenticationServiceType = AuthenticationService()
    var userService: UserServiceType = StubUserService() //TODO: stub교체
    var roomService: RoomServiceType = StubRoomService() //TODO: stub교체
    var editRoomService: EditRoomServiceType = EditRoomService() //TODO: stub교체
    var matchRoomService: MatchRoomServiceType = StubMatchRoomService() //TODO: stub교체
    var remoteConfigService: RemoteConfigServiceType = FirebaseRemoteConfigService.shared
}


class StubService: ServiceType {
    
    var appService: AppServiceType = StubAppService()
    var authService: AuthenticationServiceType = StubAuthenticationService()
    var userService: UserServiceType = StubUserService()
    var roomService: RoomServiceType = StubRoomService()
    var editRoomService: EditRoomServiceType = EditRoomService()
    var matchRoomService: MatchRoomServiceType = StubMatchRoomService()
    var remoteConfigService: RemoteConfigServiceType = StubRemoteConfigService()
    
}
