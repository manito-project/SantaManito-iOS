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
    }
    
    struct State {
        var isLoading = false
        var doneButtonDisabled = true
    }
    
    //MARK: - Dependency
    
    private let navigationRouter: NavigationRoutableType
    private let userService: UserServiceType
    private let userDefaultsService: UserDefaultsServiceType.Type
    
    @Published private(set) var state = State()
    @Published var username: String = ""
    
    private var oldUsername = ""
    private let cancelBag = CancelBag()
    
    //MARK: - Init
    
    init(userService: UserServiceType,
         userDefaultsService: UserDefaultsServiceType.Type = UserDefaultsService.self,
         navigationRouter: NavigationRoutableType) {
        self.userService = userService
        self.navigationRouter = navigationRouter
        self.userDefaultsService = userDefaultsService
        
        observe()
    }
    
    //MARK: - Methods
    
    func send(_ action: Action) {
        weak var owner = self
        guard let owner else { return }
        
        switch action {
        case .onAppear:
            userService.getUser(with: userDefaultsService.userID)
                .receive(on: DispatchQueue.main)
                .assignLoading(to: \.state.isLoading, on: owner)
                .map { $0.username }
                .catch { _ in Empty() }
                .sink { [weak self] username in
                    self?.oldUsername = username
                    self?.username = username
                }
                .store(in: cancelBag)
            
        case .doneButtonDidTap:
            userService.editUsername(with: username)
                .receive(on: DispatchQueue.main)
                .assignLoading(to: \.state.isLoading, on: owner)
                .catch { _ in Empty() }
                .sink { [weak self] username in
                    self?.navigationRouter.popToRootView()
                }
                .store(in: cancelBag)
                
                
            return
        }
    }
    
    private func observe() {
        $username
            .map { $0.isEmpty || $0 == self.oldUsername}
            .assign(to: \.state.doneButtonDisabled, on: self)
            .store(in: cancelBag)
    }
    
    
    
        
}
