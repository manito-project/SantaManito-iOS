//
//  EnterRoomTaxonomy.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 3/3/25.
//

import Foundation

extension AnalyticsTaxonomy {
    static let inviteCode = AnalyticsTaxonomy(
        tag: "입장하기_초대코드입력",
        tagEng: "invite_code",
        type: .page
    )
    
    static let inviteCodeEnterBtn = AnalyticsTaxonomy(
        tag: "입장하기_입장하기버튼",
        tagEng: "invite_code_enter_btn",
        type: .button
    )
}
