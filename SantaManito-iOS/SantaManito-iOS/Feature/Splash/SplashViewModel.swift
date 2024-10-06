//
//  SplashViewModel.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/13/24.
//

import Foundation
import Combine

class SplashViewModel: ObservableObject {
    
//MARK: - Action, State
    
    enum Action {
        case onAppear
    }
    
    
    struct State {
        var serverCheckAlert: (isPresented: Bool, message: String) = (false, "서버 점검 시간입니다")
        var desination: Destination = .splash
        
        enum Destination {
            case splash
            case onboarding
            case main
        }
    }
    
    //MARK: - Dependency
    
    var authService: AuthenticationServiceType
    var remoteConfigService: RemoteConfigServiceType
    
    //MARK: - Properties
    
    @Published var state = State()
    private let cancelBag = CancelBag()

    //MARK: - Init
    
    init(
        authService: AuthenticationServiceType,
        remoteConfigService: RemoteConfigServiceType
    ) {
        self.authService = authService
        self.remoteConfigService = remoteConfigService
    }
    
    //MARK: - Methods
    
    func send(_ action: Action) {
        weak var owner = self
        guard let owner else { return }
        switch action {
        case .onAppear:
            
            authService.autoLogin()
                .receive(on: DispatchQueue.main)
                .map { State.Destination.main }
                .catch { _ in Just(State.Destination.onboarding) }
                .assign(to: \.state.desination, on: owner)
                .store(in: cancelBag)
            
            remoteConfigService.getServerCheck()
                .filter { $0 }
                .map { _ in }
                .flatMap(remoteConfigService.getServerCheckMessage)
                .receive(on: DispatchQueue.main)
                .catch { _ in Empty() }
                .map { (true, $0 ) }
                .assign(to: \.state.serverCheckAlert, on: owner)
                .store(in: cancelBag)
            

        }
    }
}
    
