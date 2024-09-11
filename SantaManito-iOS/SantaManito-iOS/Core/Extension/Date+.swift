//
//  Date+.swift
//  SantaManito-iOS
//
//  Created by 류희재 on 9/10/24.
//

import Foundation

extension Date {
    
    init?(year: Int, month: Int, day: Int) {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        guard let date = Calendar.current.date(from: components) else {
            return nil
        }
        self = date
    }
    
    var toDuedateTime: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "a h:mm"
        return formatter.string(from: self)
    }
    
    var toDueDateAndTime: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy/MM/dd a h:mm"
        return formatter.string(from: self)
    }
    
    var toDueDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.string(from: self)
    }
    
    
}

extension String {
    
    var toChatDate: Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy.MM.dd E"
        return formatter.date(from: self)
    }
}
