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
    func track(_ taxonomy: AnalyticsTaxonomy) {
        let event = taxonomy.toAmplitudeEvent()
        amplitude.track(
            event: event,
            options: nil,
            callback: nil
        )
    }
    
    func reset() {
        amplitude.reset()
    }
}

extension AnalyticsTaxonomy {
    func toAmplitudeEvent() -> BaseEvent {
        let eventType = self.type.rawValue
        let eventProperties = self.toDictionary()
        
        return BaseEvent(
            eventType: eventType,
            eventProperties: eventProperties
        )
    }
}

