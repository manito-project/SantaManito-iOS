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
    
    @MainActor func send(action: Action) {
        switch action {
        case .onAppear:
            Analytics.shared.track(.manittoMatching)
            Analytics.shared.track(.manittoMatchingLottie)
            
            performTask(
                loadingKeyPath: \.state.isAnimating,
                operation: { try await self.roomService.matchRoom(with: self.roomID) },
                onSuccess: { [weak self] _ in
                    guard let self else { return }
                    self.getRoomInfo(self.roomID)
                }, onError: { [weak self] _ in
                    self?.state.alert = (true, "방 매칭에 실패했습니다.\n잠시 후 다시 시도해주세요.")
                }
            )
            
        case .goToMatchingResultView:
            guard let roomInfo else { return }
            self.navigationRouter.push(to: .matchedRoom(roomInfo: roomInfo))
            
        case .alert(.confirm):
            state.alert = (false, "")
            navigationRouter.popToRootView()

        }
    }
}

extension MatchingViewModel {
    @MainActor
    func getRoomInfo(_ roomID: String) {
        performTask(
            operation: { try await self.roomService.getRoomInfo(with: roomID) },
            onSuccess: { [weak self] roomDetail in
                self?.roomInfo = roomDetail
                self?.state.isMatched = true
            }
        )
    }
}
