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
