//
//  Version.swift
//  SantaManito-iOS
//
//  Created by 장석우 on 10/4/24.
//

import Foundation

struct Version {
    
    let major: Int
    let minor: Int
    let patch: Int


    init(_ versionString: String) {
        let versions = versionString.split(separator: ".").map{ Int($0)! }
        self.major = versions[0]
        self.minor = versions[1]
        self.patch = versions[2]
    }
}

extension Version : Comparable {
    
    static func < (lhs: Version, rhs: Version) -> Bool {
        guard lhs.major < rhs.major else { return false }
        guard lhs.minor < rhs.minor else { return false }
        return lhs.patch < rhs.patch
    }
    
}
