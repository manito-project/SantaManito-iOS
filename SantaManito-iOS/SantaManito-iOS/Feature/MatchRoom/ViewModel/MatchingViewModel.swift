//
//  MatchingViewModel.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/12/24.
//

import Foundation
import Combine

import Foundation
import Combine

class MatchingViewModel: ObservableObject {
    
    
    //MARK: Action, State
    
    enum Action {
        case onAppear
        case goToMatchingResultView
        case alert(AlertAction)
    }
    
    
    enum AlertAction {
        case confirm
    }
    
    
    struct State {
        var isAnimating: Bool = false
        var isMatched: Bool = true
        var alert = (isPresented: false, title: "")
    }
    
    //MARK: Dependency
    
    private var roomService: RoomServiceType
    private var navigationRouter: NavigationRoutable
    private let roomID: String
    fileprivate var roomInfo: RoomDetail?
    
    //MARK: Init
    
    init(
        roomService: RoomServiceType,
        navigationRouter: NavigationRoutable,
        roomID: String
    ) {
        self.roomService = roomService
        self.navigationRouter = navigationRouter
        self.roomID = roomID
    }
    
    //MARK: Properties
    
    @Published private(set) var state = State()
    private let cancelBag = CancelBag()
    
    //MARK: Methods
    
    func send(action: Action) {
        weak var owner = self
        guard let owner else { return }
        
        switch action {
        case .onAppear:
            AnalyticsTaxonomy.manittoMatching
            Just(self.roomID)
                .handleEvents(receiveRequest: {
                    AnalyticsTaxonomy.manittoMatchingLottie
                })
                .flatMap(roomService.matchRoom)
                .map { owner.roomID }
                .flatMap(roomService.getRoomInfo)
                .receive(on: RunLoop.main)
                .assignLoading(to: \.state.isAnimating, on: owner)
                .catch { [weak self]_  in
                    self?.state.alert = (true, "방 매칭에 실패했습니다.\n잠시 후 다시 시도해주세요.")
                    self?.state.isAnimating = false
                    return Empty<RoomDetail, Never>()
                }
                .sink { roomDetail in
                    owner.roomInfo = roomDetail
                    owner.state.isMatched = true
                }
                .store(in: cancelBag)
            
        case .goToMatchingResultView:
            guard let roomInfo else { return }
            self.navigationRouter.push(to: .matchedRoom(roomInfo: roomInfo))
            
        case .alert(.confirm):
            self.state.alert = (false, "")
            navigationRouter.popToRootView()

        }
    }
}
