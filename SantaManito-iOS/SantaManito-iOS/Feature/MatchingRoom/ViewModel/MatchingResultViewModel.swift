//
//  MatchingResultViewModel.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/12/24.
//

import Foundation
import Combine

class MatchingViewModel: ObservableObject {
    
    //MARK: Action
    
    enum Action {
        case load
    }
    
    @Published private(set) var state = State(
        isAnimating: false
    )
    
    //MARK: State
    
    struct State {
        var isAnimating: Bool
    }
    
    //MARK: send
    
    func send(action: Action) {
        switch action {
        case .load:
            //TODO: 마니또 서버 통신
            //TODO: isMatched 변수 변경
            break
        }
    }
}

