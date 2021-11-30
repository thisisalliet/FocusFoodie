//
//  Calendar+Eextension.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/30.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

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
