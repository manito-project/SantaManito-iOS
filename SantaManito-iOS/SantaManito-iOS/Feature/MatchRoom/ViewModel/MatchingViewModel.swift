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
    }
    
    struct State {
        var isAnimating: Bool = false
    }
    
    //MARK: Dependency
    
    private var roomService: MatchRoomServiceType
    
    //MARK: Init
    
    init(roomService: MatchRoomServiceType) {
        self.roomService = roomService
    }
    
    //MARK: Properties
    
    @Published private(set) var state = State()
    private let cancelBag = CancelBag()
    
    //MARK: Methods
    
    func send(action: Action) {
        switch action {
            //TODO: 마니또 서버 통신
            //TODO: isMatched 변수 변경
        case .onAppear:
            self.state.isAnimating = true
            roomService.matchPlayer()
                .catch { _ in Empty() }
                .sink { [weak self] _ in
                    //화면 전환
                    self?.state.isAnimating = false
                    print("성공해서 화면 전환")
                }
                .store(in: cancelBag)
        }
    }
}
