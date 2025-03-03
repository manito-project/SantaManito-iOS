//
//  OnboadringTaxonomy.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 3/3/25.
//

import Foundation

extension AnalyticsTaxonomy {
    static let onboardingName = AnalyticsTaxonomy(
        tag: "온보딩_닉네임입력",
        tagEng: "onboarding_name",
        type: .page
    )
    
    static let onboardingPersonalInformation = AnalyticsTaxonomy(
        tag: "온보딩_약관동의",
        tagEng: "onboarding_personal_information",
        type: .page
    )
}
