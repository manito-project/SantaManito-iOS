//
//  ShowAllResultViewModel.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/23/24.
//

import Foundation
import Combine

class ShowAllResultViewModel: ObservableObject {
    
    //MARK: Action, State
    
    enum Action {
        case onAppear
        case goHomeButtonClicked
        case deleteRoomButtonClicked
    }
    
    struct State {
        var participateList: [MatchingFinishData] = []
        var roomName: String = ""
        var description: String = ""
    }
    
    //MARK: Dependency
    
    
    private var roomService: RoomServiceType
    private var matchRoomService: MatchRoomServiceType
    private var editRoomService: EditRoomServiceType
    private var navigationRouter: NavigationRoutableType
    
    //MARK: Init
    
    init(
        roomService: RoomServiceType,
        matchRoomService: MatchRoomServiceType,
        editRoomService: EditRoomServiceType,
        navigationRouter: NavigationRoutableType
    ) {
        self.roomService = roomService
        self.matchRoomService = matchRoomService
        self.editRoomService = editRoomService
        self.navigationRouter = navigationRouter
    }
    
    //MARK: Properties
    
    @Published private(set) var state = State()
    private let cancelBag = CancelBag()
    
    //MARK: Methods
    
    func send(action: Action) {
        switch action {
        case .onAppear:
            matchRoomService.getManitoResult("")
                .catch { _ in Empty() }
                .assign(to: \.state.participateList, on: self)
                .store(in: cancelBag)
            
            roomService.fetch(with: "roomID")
                .map { [weak self] roomInfo in
                    self?.state.roomName = roomInfo.name
                    let startDate = roomInfo.expirationDate.adjustDays(remainingDays: -Int(roomInfo.remainingDays)!).toDueDate
                    let endDate = roomInfo.expirationDateToString
                    return "\(startDate) ~ \(endDate)\n\(roomInfo.remainingDays)일간의 산타마니또 끝!"
                }
                .catch { _ in Empty() }
                .assign(to: \.state.description, on: self)
                .store(in: cancelBag)
            
        case .goHomeButtonClicked:
            navigationRouter.popToRootView()
            
        case .deleteRoomButtonClicked:
            editRoomService.deleteRoom(with: "roomID")
                .catch { _ in Empty() }
                .sink(receiveCompletion: { _ in
                    
                }, receiveValue: { [weak self] _ in
                    self?.navigationRouter.popToRootView()
                })
        }
    }
}
