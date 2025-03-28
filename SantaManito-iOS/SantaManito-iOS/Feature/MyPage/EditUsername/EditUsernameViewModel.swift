//
//  EditUsernameViewModel.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/24/24.
//

import Foundation
import Combine

final class EditUsernameViewModel: ObservableObject {
    
    enum Action {
        case onAppear
        case doneButtonDidTap
        case deleteAccountButtonDidTap
        case alert(Alert)
        
        enum Alert {
            case deleteButtonDidTap
            case stayButtonDidTap
        }
    }
    
    struct State {
        var isLoading = false
        var doneButtonDisabled = true
        var isDeleteAccountAlertPresented = false
    }
    
    //MARK: - Dependency
    
    private let navigationRouter: NavigationRoutableType
    private let windowRouter: WindowRoutableType
    private let userService: UserServiceType
    private let userDefaultsService: UserDefaultsServiceType
    
    @Published private(set) var state = State()
    @Published var username: String = ""
    
    private var oldUsername = ""
    private let cancelBag = CancelBag()
    
    //MARK: - Init
    
    init(userService: UserServiceType,
         userDefaultsService: UserDefaultsServiceType = UserDefaultsService.shared,
         navigationRouter: NavigationRoutableType,
         windowRouter: WindowRoutableType
    ) {
        self.userService = userService
        self.navigationRouter = navigationRouter
        self.userDefaultsService = userDefaultsService
        self.windowRouter = windowRouter
        
        observe()
    }
    
    //MARK: - Methods
    
    func send(_ action: Action) {
        weak var owner = self
        guard let owner else { return }
        
        switch action {
        case .onAppear:
            Analytics.shared.track(.nameEdit)
            userService.getUser(with: userDefaultsService.userID)
                .receive(on: RunLoop.main)
                .assignLoading(to: \.state.isLoading, on: owner)
                .map { $0.username }
                .catch { _ in Empty() }
                .sink { [weak self] username in
                    self?.oldUsername = username
                    self?.username = username
                }
                .store(in: cancelBag)
            
        case .doneButtonDidTap:
            Analytics.shared.track(.nameEditCompleteBtn)
            userService.editUsername(with: username)
                .receive(on: RunLoop.main)
                .assignLoading(to: \.state.isLoading, on: owner)
                .catch { _ in Empty() }
                .sink { [weak self] username in
                    self?.navigationRouter.popToRootView()
                }
                .store(in: cancelBag)
        case .deleteAccountButtonDidTap:
            Analytics.shared.track(.nameEditWithdrawalBtn)
            state.isDeleteAccountAlertPresented = true
            Analytics.shared.track(.withdrawalPopup)
        case .alert(.deleteButtonDidTap):
            Analytics.shared.track(.withdrawalPopupWithdrawalBtn)
            state.isDeleteAccountAlertPresented = false
            userService.deleteAccount()
                .receive(on: RunLoop.main)
                .assignLoading(to: \.state.isLoading, on: owner)
                .catch { _ in Empty() }
                .receive(on: RunLoop.main)
                .sink { _ in
                    owner.userDefaultsService.removeAll()
                    owner.windowRouter.switch(to: .splash)
                    owner.navigationRouter.popToRootView()
                }
                .store(in: cancelBag)
        case .alert(.stayButtonDidTap):
            Analytics.shared.track(.withdrawalPopupStayBtn)
            state.isDeleteAccountAlertPresented = false
        }
    }
    
    private func observe() {
        $username
            .map { $0.isEmpty || $0 == self.oldUsername}
            .assign(to: \.state.doneButtonDisabled, on: self)
            .store(in: cancelBag)
    }
    
    
    
        
}
