//
//  Analytics.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 3/2/25.
//

import Foundation

protocol Analyzable {
    func track(eventType: String, eventProperties: [String: Any?])
    func reset()
}

final class Analytics {
    
    private var analytics: [any Analyzable] = []
    static let shared = Analytics()
    
    private init() {
        self.analytics = [
            AmplitudeAnalytics.shared
        ]
    }
}

extension Analytics: Analyzable {
    func track(eventType: String, eventProperties: [String: Any?]) {
        analytics.forEach {
            $0.track(eventType: eventType, eventProperties: eventProperties)
        }
    }
    
    func reset() {
        analytics.forEach {
            $0.reset()
        }
    }
}
