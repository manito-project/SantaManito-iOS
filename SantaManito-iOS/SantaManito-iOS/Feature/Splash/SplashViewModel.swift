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
            
            appService.isLatestVersion()
                .receive(on: DispatchQueue.main)
                .sink { isLatestVersion in
                    
                    guard isLatestVersion else {
                        owner.state.mustUpdateAlertIsPresented = true
                        return
                    }
                    
                    Just(owner.appService.getDeviceIdentifier() ?? "" )
                        .filter { !$0.isEmpty }
                        .flatMap(owner.authService.signIn)
                        .receive(on: DispatchQueue.main)
                        .map {
                            owner.userDefaultsService.userID = $0.userID
                            owner.userDefaultsService.accessToken = $0.accessToken
                            return State.Destination.main
                        }
                        .catch { _ in Just(State.Destination.onboarding) }
                        .assign(to: \.state.desination, on: owner)
                        .store(in: owner.cancelBag)
                    
                    owner.remoteConfigService.getServerCheck()
                        .receive(on: DispatchQueue.main)
                        .filter { $0 }
                        .map { _ in }
                        .flatMap(owner.remoteConfigService.getServerCheckMessage)
                        .receive(on: DispatchQueue.main)
                        .catch { _ in Empty() }
                        .map { (true, $0 ) }
                        .assign(to: \.state.serverCheckAlert, on: owner)
                        .store(in: owner.cancelBag)
                    
                }
                .store(in: cancelBag)

            

        }
    }
}
    
