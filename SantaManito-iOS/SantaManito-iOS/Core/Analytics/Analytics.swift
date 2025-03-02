//
//  Analytics.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 3/2/25.
//

import Foundation
import AmplitudeSwift

struct Analytics {
    
    private let amplitude = Amplitude(configuration: Configuration(apiKey: Config.amplitudeAPIKey))
    
    func configure() {
        
    }
}
