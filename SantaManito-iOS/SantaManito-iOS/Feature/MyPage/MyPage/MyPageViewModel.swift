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
        let items = MyPageItem.allCases
        var isPresentedWebView = (isPresented: false, url: "")
    }
    
    private var navigationRouter: NavigationRoutableType
    @Published var state = State()
    
    init(navigationRouter: NavigationRoutableType) {
        self.navigationRouter = navigationRouter
    }
    
    func send(_ action: Action) {
        switch action {
        case let .cellDidTap(item):
            switch item {
            case .editUsername:
                navigationRouter.push(to: .editUsername)
            
            case .inquiry, .termsOfUse, .privacyPolicy:
                guard let url = item.url else { return}
                state.isPresentedWebView = (true, url)
            }
            
        }
        
        
    }
}