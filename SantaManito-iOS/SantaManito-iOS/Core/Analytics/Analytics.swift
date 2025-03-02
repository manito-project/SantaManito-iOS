//
//  Analytics.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 3/2/25.
//

import Foundation

protocol Analyzable {
    func track(_ taxonomy: AnalyticsTaxonomy)
    func reset()
}

final class Analytics {
    static let shared = Analytics()
    
    private init() { }
}

extension Analytics: Analyzable {
    func track(_ taxonomy: AnalyticsTaxonomy) {
        AmplitudeAnalytics.shared.track(taxonomy)
    }
    
    func reset() {
        AmplitudeAnalytics.shared.reset()
    }
}
