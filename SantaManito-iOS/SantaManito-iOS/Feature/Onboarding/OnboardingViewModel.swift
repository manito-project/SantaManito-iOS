//
//  OnboardingNicknameViewModel.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/13/24.
//

import Foundation
import Combine

enum AgreementModel: CaseIterable {
    case 이용약관
    case 개인정보
    
    var required: Bool {
        switch self {
        case .이용약관: return true
        case .개인정보: return true
        }
    }
    
    var title: String {
        switch self {
        case .이용약관: "이용 약관 동의"
        case .개인정보: "개인정보 수집 및 이용 동의"
        }
    }
    
    var url: String {
        switch self {
        case .이용약관: "https://www.notion.so/am2pm/c292b4973da6420ab63de1571feae786?pvs=4"
        case .개인정보: "https://www.notion.so/52ba45cda67c4c8c83ea67aab1c042fe?pvs=4"
        }
    }
}

final class OnboardingViewModel: ObservableObject {
    
    //MARK: - Action, State
    
    enum Action {
        // step 1, 2
        case bottomButtonDidTap
        
        // step 2
        case acceptAllCellDidTap
        case agreementCellDidTap(AgreementModel)
        case agreementDetailButtonDidTap(AgreementModel)
    }
    
    struct State {
        var step: Step = .nickname // step
        var bottomButtonDisabled = true // step1, step2 모두 쓰이는 bottom Button state입니다
        var isLoading = false
        var failAlert = false
        var signUpCompleted = false // step 2 까지 끝나면 true로
        var agreements = AgreementModel.allCases.map { (agreement: $0, isSelected: false) }
        var allAccepted: Bool { agreements.allSatisfy { $0.isSelected } }
        var agreementWebView = (isPresented: false, url: "")
        
        fileprivate var requiredAccepted: Bool {agreements.filter { $0.agreement.required }.allSatisfy { $0.isSelected }  } // 뷰에선 사용하지 않는 프로퍼티
        
        enum Step {
            case nickname
            case agreement
        }
    }
    //MARK: - Dependency
    
    private let appService: AppServiceType
    private let authService: AuthenticationServiceType
    private var userDefaultsService: UserDefaultsServiceType
    private var windowRouter: WindowRoutableType
    
    //MARK: - Properties
    
    @Published var state = State()
    @Published var nickname = ""
    
    private let cancelBag = CancelBag()
    
    //MARK: - Init
    
    init(
        appService: AppServiceType,
        authService: AuthenticationServiceType,
        userDefaultsService: UserDefaultsServiceType = UserDefaultsService.shared,
        windowRouter: WindowRoutableType
    ) {
        self.appService = appService
        self.authService = authService
        self.userDefaultsService = userDefaultsService
        self.windowRouter = windowRouter
        
        observe()
    }
    
    //MARK: - Method

    func send(_ action: Action) {
        
        weak var owner = self
        guard let owner else { return }
        
        switch action {
        case .bottomButtonDidTap:
            switch state.step {
            case .nickname:
                state.step = .agreement
                state.bottomButtonDisabled = true
                
            case .agreement:
                
                Just(appService.getDeviceIdentifier() ?? "")
                    .filter { !$0.isEmpty }
                    .flatMap { owner.authService.signUp(nickname: owner.nickname, deviceID: $0) }
                    .assignLoading(to: \.state.isLoading, on: owner)
                    .catch { _ in
                        owner.state.failAlert = true
                        return Empty<AuthEntity, Never>()
                    }
                    .sink { auth in
                        owner.userDefaultsService.userID = auth.userID
                        owner.userDefaultsService.accessToken = auth.accessToken
                        owner.windowRouter.switch(to: .main)
                    }
                    .store(in: cancelBag)
            }
            
        case .acceptAllCellDidTap:
            let oldValue = state.allAccepted
            let newValue = !oldValue
            
            for i in state.agreements.indices {
                state.agreements[i].isSelected = newValue
            }
            
            state.bottomButtonDisabled = !state.requiredAccepted
            
        case let .agreementCellDidTap(agreement):
            for i in state.agreements.indices {
                guard state.agreements[i].agreement == agreement else { continue }
                state.agreements[i].isSelected.toggle()
            }
            
            state.bottomButtonDisabled = !state.requiredAccepted
        case let .agreementDetailButtonDidTap(agreement):
            state.agreementWebView = (true, agreement.url)
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
