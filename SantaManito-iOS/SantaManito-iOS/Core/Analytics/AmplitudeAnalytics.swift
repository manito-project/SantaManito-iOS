//
//  AmplitudeAnalytics.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 3/2/25.
//

import Foundation
import AmplitudeSwift

final class AmplitudeAnalytics {
    static let shared = AmplitudeAnalytics()
    private let amplitude = Amplitude(configuration: Configuration(apiKey: Config.amplitudeAPIKey))
    
    private init() {}
}

extension AmplitudeAnalytics: Analyzable {
    func track(eventType: String, eventProperties: [String: Any?]) {
        let event = BaseEvent(eventType: eventType, eventProperties: eventProperties)
        amplitude.track(event: event, options: nil, callback: nil)
    }
    
    func reset() {
        amplitude.reset()
    }
}
