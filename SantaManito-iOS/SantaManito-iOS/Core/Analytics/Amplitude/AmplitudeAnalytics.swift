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
    #if DEBUG
    private let amplitude = Amplitude(configuration: Configuration(apiKey: XcodeInfo[.AMPLITUDE_API_KET_DEBUG]))
    #else
    private let amplitude = Amplitude(configuration: Configuration(apiKey: XcodeInfo[.AMPLITUDE_API_KET_PROD]))
    #endif
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
        var eventProperties: [String: Any?] = [
            "tag" : self.tag,
            "tag_eng": self.tagEng,
            "channel": self.channel,
        ]
        properties.forEach {
            eventProperties.updateValue($0.value, forKey: $0.key)
        }
        
        return BaseEvent(
            eventType: eventType,
            eventProperties: eventProperties
        )
    }
}

