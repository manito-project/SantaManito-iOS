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
    
    @MainActor
    func send(_ action: Action) {
        weak var owner = self
        guard let owner else { return }
        
        switch action {
        case .onAppear:
            Analytics.shared.track(.nameEdit)
            performTask(
                loadingKeyPath: \.state.isLoading,
                operation: { try await self.userService.getUser(with: self.userDefaultsService.userID) },
                onSuccess: { [weak self] user in
                    self?.oldUsername = user.username
                    self?.username = user.username
                }
            )
            
        case .doneButtonDidTap:
            Analytics.shared.track(.nameEditCompleteBtn)
            performTask(
                loadingKeyPath: \.state.isLoading,
                operation: { try await self.userService.editUsername(with: self.username) },
                onSuccess: { [weak self] _ in
                    self?.navigationRouter.popToRootView()
                }
            )
            
        case .deleteAccountButtonDidTap:
            Analytics.shared.track(.nameEditWithdrawalBtn)
            state.isDeleteAccountAlertPresented = true
            Analytics.shared.track(.withdrawalPopup)
            
        case .alert(.deleteButtonDidTap):
            Analytics.shared.track(.withdrawalPopupWithdrawalBtn)
            state.isDeleteAccountAlertPresented = false
            performTask(
                loadingKeyPath: \.state.isLoading,
                operation: { try await self.userService.deleteAccount() },
                onSuccess: { [weak self] _ in
                    self?.userDefaultsService.removeAll()
                    self?.windowRouter.switch(to: .splash)
                    self?.navigationRouter.popToRootView()
                }
            )
            
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
