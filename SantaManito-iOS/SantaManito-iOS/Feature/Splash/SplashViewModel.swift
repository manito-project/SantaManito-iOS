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
        var mustUpdateAlertIsPresented: Bool = false
        var serverCheckAlert: (isPresented: Bool, message: String) = (false, "서버 점검 시간입니다")
        var desination: Destination = .splash
        
        enum Destination {
            case splash
            case onboarding
            case main
        }
    }
    
    //MARK: - Dependency
    
    private let appService: AppServiceType
    private let authService: AuthenticationServiceType
    private let userDefaultsService: UserDefaultsServiceType.Type
    private let remoteConfigService: RemoteConfigServiceType
    
    //MARK: - Properties
    
    @Published var state = State()
    private let cancelBag = CancelBag()

    //MARK: - Init
    
    init(
        appService: AppServiceType,
        remoteConfigService: RemoteConfigServiceType,
        authService: AuthenticationServiceType,
        userDefaultsService: UserDefaultsServiceType.Type = UserDefaultsService.self
    ) {
        self.appService = appService
        self.remoteConfigService = remoteConfigService
        self.authService = authService
        self.userDefaultsService = userDefaultsService
    }
    
    //MARK: - Methods
    
    func send(_ action: Action) {
        weak var owner = self
        guard let owner else { return }
        switch action {
        case .onAppear:
            
            guard appService.isLatestVersion() else {
                state.mustUpdateAlertIsPresented = true
                return
            }
            
            Just(appService.getDeviceIdentifier() ?? "" )
                .filter { !$0.isEmpty }
                .flatMap(authService.signIn)
                .map {
                    owner.userDefaultsService.userID = $0.userID
                    owner.userDefaultsService.accessToken = $0.accessToken
                    return State.Destination.main
                }
                .catch { _ in Just(State.Destination.onboarding) }
                .assign(to: \.state.desination, on: owner)
                .store(in: cancelBag)
            
            remoteConfigService.getServerCheck()
                .filter { $0 }
                .map { _ in }
                .flatMap(remoteConfigService.getServerCheckMessage)
                .catch { _ in Empty() }
                .map { (true, $0 ) }
                .assign(to: \.state.serverCheckAlert, on: owner)
                .store(in: cancelBag)
            

        }
    }
}
    
