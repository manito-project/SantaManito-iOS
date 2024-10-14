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
    
    
    
    var toDueDateTime: String {
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
    
    var toDueDateWithoutYear: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "MM월 dd일"
        return formatter.string(from: self)
    }
    
    func addingDays(_ days: Int) -> Date {
       return self.addingTimeInterval(Double(days * 24 * 60 * 60))
    }
    
    func daysBetweenInSeoulTimeZone(_ date: Date) -> Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
        let start = calendar.startOfDay(for: self)
        let end = calendar.startOfDay(for: date)
        let components = calendar.dateComponents([.day], from: start, to: end)
        return components.day ?? 0
    }
    
    var startOfDay: Date {
        return Date(timeIntervalSince1970: floor(self.timeIntervalSince1970 / 86400) * 86400)
    }
    
}

extension String {
    func toDate(withFormat format: String = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.date(from: self)
    }
}
