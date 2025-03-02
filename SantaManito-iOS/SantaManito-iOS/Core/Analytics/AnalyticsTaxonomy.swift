//
//  Taxonomy.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 3/2/25.
//

import Foundation

struct AnalyticsTaxonomy {
    
    enum EventType: String {
        case page
        case button
        case modal
    }
    
    let tag: String
    let tagEng: String
    let type: EventType
    let channel: String
    var properties: [String: Any?]
    
    init(
        tag: String,
        tagEng: String,
        type: EventType,
        channel: String = "APP",
        properties: [String: Any?] = [:]
    ) {
        self.tag = tag
        self.tagEng = tagEng
        self.type = type
        self.channel = channel
        self.properties = properties
    }

    @discardableResult
    mutating func add(_ value: Any?, forKey key: String) -> Self {
        self.properties[key] = value
        return self
    }
}

