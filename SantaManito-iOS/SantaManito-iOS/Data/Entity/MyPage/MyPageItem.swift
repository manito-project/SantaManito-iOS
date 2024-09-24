//
//  MyPage.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 9/24/24.
//

import Foundation

enum MyPageItem: CaseIterable {
    
    case editUsername
    case inquiry // 문의 하기
    case termsOfUse
    case privacyPolicy

    var title: String {
        switch self {
        case .editUsername:
            "이름 수정"
        case .inquiry:
            "문의하기"
        case .termsOfUse:
            "서비스 이용약관"
        case .privacyPolicy:
            "개인정보 처리방침"
        }
    }
    
    var url: String? {
        switch self {
        case .editUsername:
            nil
        case .inquiry:
            "https://pf.kakao.com/_hxkGIn"
        case .termsOfUse:
            "https://abit.ly/rdj0d7"
        case .privacyPolicy:
            "https://abit.ly/1faheg"
        }
    }
}
