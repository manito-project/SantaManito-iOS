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
    
    @Published private(set) var state = State()
    @Published var username: String = ""
    
    private var oldUsername = ""
    private let cancelBag = CancelBag()
    
    //MARK: - Init
    
    init(userService: UserServiceType, navigationRouter: NavigationRoutableType) {
        self.userService = userService
        self.navigationRouter = navigationRouter
        
        observe()
    }
    
    //MARK: - Methods
    
    func send(_ action: Action) {
        weak var owner = self
        guard let owner else { return }
        
        switch action {
        case .onAppear:
            userService.getUser(with: "") // TODO: KeyChain에서 가져오기
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
            state.isLoading = true
            userService.editUsername(with: username)
                .receive(on: DispatchQueue.main)
                .catch { _ in Empty() }
                .sink { [weak self] username in
                    self?.state.isLoading = false
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
