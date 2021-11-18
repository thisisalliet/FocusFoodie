//
//  Timestamp+Extension.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/31.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

extension Timestamp {
    
    static func timeFormat(time: Timestamp) -> String {
        
        let timeInterval = time
        
        let date = timeInterval.dateValue()
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyy/MM/dd HH:mm"
        
        let formatTime = dateFormatter.string(from: date as Date)
        
        return formatTime
    }
}

extension Date {
    
    static let date = Date()
    
    static let dateFormatter = DateFormatter()
    
    func monthOfDate() -> String {
        
        Date.dateFormatter.dateFormat = "LLLL"
        
        return Date.dateFormatter.string(from: self).capitalized
    }
    
    func currentDate() -> String {
        
        Date.dateFormatter.dateFormat = "dd"
        
        return Date.dateFormatter.string(from: self).uppercased()
    }
    
    func dayOfWeek() -> String {
                
        Date.dateFormatter.dateFormat = "EEEE"
        
        return Date.dateFormatter.string(from: self).capitalized
    }
    
    func dateOfWeek() -> String {
                
        Date.dateFormatter.dateFormat = "dd"
        
        return Date.dateFormatter.string(from: self)
    }
}

extension Calendar {
    
  func intervalOfWeek(for date: Date) -> DateInterval? {
      
    dateInterval(of: .weekOfYear, for: date)
  }

  func startOfWeek(for date: Date) -> Date? {
      
    intervalOfWeek(for: date)?.start
  }

  func daysWithSameWeekOfYear(as date: Date) -> [Date] {
      
    guard let startOfWeek = startOfWeek(for: date) else {
        
      return []
    }

    return (0 ... 6).reduce(into: []) { result, daysToAdd in
      result.append(Calendar.current.date(byAdding: .day, value: daysToAdd, to: startOfWeek))
    }
    .compactMap { $0 }
  }
}
