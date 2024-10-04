//
//  URLs.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/30/24.
//

public enum Paths {
    
    //MARK: - Auth
    
    static let signUp = "/auth/sign-up"
    static let signIn = "/auth/sign-in"
    
    //MARK: - User
    
    static let editNickName = "/users/my/nickname"
    static let deleteAccount = "/users/my"
    static let getUserData = "/users"
    
    //MARK: - Room
    
    static let createRoom = "/rooms"
    static let getRooms = "/rooms"
    static let getRoomDetail = "/rooms/{roomId}"
    static let editRoomInfo = "/rooms/{roomId}"
    static let deleteRoom = "/rooms/{roomId}"
    static let getRoomMyInfo = "/rooms/{roomId}/my"
    static let matchRoom = "/rooms/{roomId}/match"
    static let enterRoom = "/rooms/enter"
    static let exitRoom = "/rooms/{roomId}/exit"
    static let deleteHistoryRoom = "/rooms/{roomId}/history"
}
