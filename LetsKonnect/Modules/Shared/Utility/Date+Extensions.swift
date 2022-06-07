//
//  Date+Extensions.swift
//  Utility
//
//  Created by L on 2022/3/29.
//


public let CreateDataFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

public extension Date {
    
    func timeAgoSinceNow(numericDates: Bool = true) -> String {
        
        let calendar = Calendar.current
        let now = Date()
        let earliest = (now as NSDate).earlierDate(self)
        let latest = (earliest == now) ? self : now
        let components: DateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.minute,NSCalendar.Unit.hour,NSCalendar.Unit.day,NSCalendar.Unit.weekOfYear,NSCalendar.Unit.month,NSCalendar.Unit.year,NSCalendar.Unit.second], from: earliest, to: latest, options: NSCalendar.Options())
        guard let year = components.year,
              let month = components.month,
              let weekOfYear = components.weekOfYear,
              let day = components.day,
              let hour = components.hour,
              let minute = components.minute, let second = components.second
        else {
            return ""
        }
        
        if year >= 1 {
            return year >= 2 ? "\(year) years ago" : numericDates ? "1 years ago" : "Last year"
        } else if month >= 1 {
            return month >= 2 ? "\(month) months ago" : numericDates ? "1 month ago" : "Last month"
        } else if weekOfYear >= 1 {
            return weekOfYear >= 2 ? "\(weekOfYear) weekOfYears ago" : numericDates ? "1 weekOfYear ago" : "Last weekOfYear"
        } else if day >= 1 {
            return day >= 2 ? "\(day) days ago" : numericDates ? "1 day ago" : "Last day"
        } else if hour >= 1 {
            return hour >= 2 ? "\(hour) hours ago" : numericDates ? "1 hour ago" : "Last hour"
        } else if minute >= 1 {
            return minute >= 2 ? "\(minute) minutes ago" : numericDates ? "1 minute ago" : "Last minute"
        } else {
            return second >= 3 ? "\(second) seconds ago" : "Just now"
        }
        
    }
    
}
