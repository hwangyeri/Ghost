//
//  Date+.swift
//  Blanky
//
//  Created by Yeri Hwang on 2024/01/03.
//

import Foundation

extension Date {
    
    // ISO8601 형식의 String -> Date 객체로 변환하는 함수
    static func date(from dateString: String) -> Date? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        return isoFormatter.date(from: dateString)
    }
    
    func timeAgo(from dateString: String) -> String {
        if let date = Date.date(from: dateString) {
            let calendar = Calendar.current
            let now = Date()
            
            // 오늘이면
            if calendar.isDateInToday(date) {
                let components = calendar.dateComponents([.hour, .minute], from: self, to: now)
                
                if let hour = components.hour, hour > 0 {
                    return "\(hour)시간 전"
                } else if let minute = components.minute, minute > 0 {
                    return "\(minute)분 전"
                } else {
                    return "방금"
                }
                // 어제인 경우
            } else if calendar.isDateInYesterday(date) {
                return "어제"
            } else {
                let components = calendar.dateComponents([.day], from: self, to: now)
                if let day = components.day, day > 0 {
                    if day > 30 {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        return dateFormatter.string(from: self)
                    } else {
                        return "\(day)일 전"
                    }
                }
                // 30일 이상인 경우
                else {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    return dateFormatter.string(from: date)
                }
            }
        }
        else {
            return ""
        }
    }
    
    
}
