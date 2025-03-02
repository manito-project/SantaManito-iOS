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
    
    init(
        tag: String,
        tagEng: String,
        type: EventType,
        channel: String = "APP"
    ) {
        self.tag = tag
        self.tagEng = tagEng
        self.type = type
        self.channel = channel
    }
}

extension AnalyticsTaxonomy: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case tag = "태그명"
        case tagEng = "tag_eng"
        case channel
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(tag, forKey: .tag)
        try container.encode(tagEng, forKey: .tagEng)
        try container.encode(channel, forKey: .channel)
    }
}
