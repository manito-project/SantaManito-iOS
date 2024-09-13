//
//  SplashViewModel.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/13/24.
//

import Combine

class SplashViewModel: ObservableObject {
    
    
    enum Action {
        case onAppear
    }
    
    
    struct State {
        var desination: Destination = .splash
        
        enum Destination {
            case splash
            case onboarding
            case main
        }
    }
    
//MARK: - Dependency
    
    var authService: AuthenticationServiceType
    
//MARK: - Properties
    
    @Published var state = State()
    private let cancelBag = CancelBag()
    
    init(authService: AuthenticationServiceType) {
        self.authService = authService
    }
    
//MARK: - Methods
    
    func send(_ action: Action) {
        switch action {
        case .onAppear:
            authService.autoLogin()
                .map { State.Destination.main }
                .catch { _ in Just(State.Destination.onboarding) }
                .assign(to: \.state.desination, on: self)
                .store(in: cancelBag)
        }
    }
}
