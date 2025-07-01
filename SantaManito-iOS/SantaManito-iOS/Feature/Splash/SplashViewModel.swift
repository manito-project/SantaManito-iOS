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
        case alert(Alert)
    }
    
    
    struct State {
        var mustUpdateAlertIsPresented: Bool = false
        var serverCheckAlert: (isPresented: Bool, message: String) = (false, "서버 점검 시간입니다")
    }
    
    enum Alert {
        case confirm
    }
    
    //MARK: - Dependency
    
    private let appService: AppServiceType
    private let authService: AuthenticationServiceType
    private var userDefaultsService: UserDefaultsServiceType
    private let remoteConfigService: RemoteConfigServiceType
    private(set) var windowRouter: WindowRoutableType
    
    //MARK: - Properties
    
    @Published var state = State()
    private let cancelBag = CancelBag()

    //MARK: - Init
    
    init(
        appService: AppServiceType,
        remoteConfigService: RemoteConfigServiceType,
        authService: AuthenticationServiceType,
        userDefaultsService: UserDefaultsServiceType = UserDefaultsService.shared,
        windowRouter: WindowRoutableType
    ) {
        self.appService = appService
        self.remoteConfigService = remoteConfigService
        self.authService = authService
        self.userDefaultsService = userDefaultsService
        self.windowRouter = windowRouter
    }
    
    //MARK: - Methods
    
    func send(_ action: Action) {
        weak var owner = self
        guard let owner else { return }
        switch action {
            
        case .onAppear:
            Analytics.shared.track(.splash)
            Task {
                let isLatestVersion = try await appService.isLatestVersion()
                
                guard isLatestVersion else {
                    self.state.mustUpdateAlertIsPresented = true
                    return
                }
                
                guard let deviceID = appService.getDeviceIdentifier(), !deviceID.isEmpty else { return }
                await performTask(
                    operation: { try await self.authService.signIn(deviceID: deviceID) },
                    onSuccess: { [weak self] auth in
                        self?.userDefaultsService.userID = auth.userID
                        self?.userDefaultsService.accessToken = auth.accessToken
                        self?.windowRouter.switch(to: .main)
                    },
                    onError: { [weak self] _ in
                        self?.windowRouter.switch(to: .onboarding)
                    }
                )
                
                owner.remoteConfigService.getServerCheck()
                    .filter { $0 }
                    .map { _ in }
                    .flatMap(owner.remoteConfigService.getServerCheckMessage)
                    .receive(on: RunLoop.main)
                    .catch { _ in Empty() }
                    .map { (true, $0 ) }
                    .assign(to: \.state.serverCheckAlert, on: owner)
                    .store(in: owner.cancelBag)
            }
        case .alert(.confirm):
            state.serverCheckAlert.isPresented = false 
        }
    }
}
    
