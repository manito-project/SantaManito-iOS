//
//  OnboardingNicknameViewModel.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/13/24.
//

import Foundation

final class OnboardingViewModel: ObservableObject {
    
    //MARK: - Action, State
    
    enum Action {
        case bottomButtonDidTap
    }
    
    struct State {
        var step: Step = .nickname
        var bottomButtonDisabled = true
        
        enum Step {
            case nickname
            case agreement
        }
    }
    //MARK: - Dependency
    
    let userService: UserServiceType
    
    //MARK: - Properties
    
    @Published var state = State()
    @Published var nickname = ""
    private let cancelBag = CancelBag()
    
    //MARK: - Init
    
    init(userService: UserServiceType) {
        self.userService = userService
        
        observe()
    }
    
    //MARK: - Method

    func send(_ action: Action) {
        switch action {
        case .bottomButtonDidTap:
            switch state.step {
            case .nickname:
                state.step = .agreement
                state.bottomButtonDisabled = true
            case .agreement:
                print("done")
            }
        }
    }
    
    func observe() {
        weak var owner = self
        guard let owner else { return }
        
        $nickname
            .filter {  _ in owner.state.step == .nickname }
            .map { $0.isEmpty }
            .assign(to: \.state.bottomButtonDisabled, on: owner)
            .store(in: cancelBag)
            
    }
    
}
