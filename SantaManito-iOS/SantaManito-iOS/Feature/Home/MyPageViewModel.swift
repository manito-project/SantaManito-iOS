//
//  MyPageViewModel.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/24/24.
//

import Foundation

class MyPageViewModel: ObservableObject {
    
    enum Action {
        case cellDidTap(MyPageItem)
    }
    
    struct State {
        let items: [MyPageItem] = MyPageItem.allCases
    }
    
    private var navigationRouter: NavigationRoutableType
    @Published private(set) var state = State()
    
    init(navigationRouter: NavigationRoutableType) {
        self.navigationRouter = navigationRouter
    }
    
    func send(_ action: Action) {
        switch action {
        case let .cellDidTap(item):
            switch item {
            case .editUsername:
                navigationRouter.push(to: .editUsername)
            case .inquiry:
                return
            case .announcement:
                return
            case .termsOfUse:
                return
            case .privacyPolicy:
                return
            }
            
        }
        
        
    }
}
