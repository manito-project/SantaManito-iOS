//
//  EnterRoomTaxonomy.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 3/3/25.
//

import Foundation

extension AnalyticsTaxonomy {
    static let inviteCode = AnalyticsTaxonomy(
        tag: "입장하기_초대코드입력_닉네임입력",
        tagEng: "onboarding_name",
        type: .page
    )
    
    static let inviteCodeEnterBtn = AnalyticsTaxonomy(
        tag: "입장하기_입장하기버튼_약관동의",
        tagEng: "onboarding_personal_information",
        type: .button
    )
}
