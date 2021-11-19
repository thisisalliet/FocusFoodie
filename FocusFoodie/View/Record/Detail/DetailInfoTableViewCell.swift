//
//  DetailTagTableViewCell.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/21.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class DetailInfoTableViewCell: UITableViewCell {
    
    var record: Record?
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var focusTimeLabel: UILabel!
    
    @IBOutlet weak var unitLabel: UILabel!
    
    func layoutCell(date: String, time: String, focusTime: Int) {
        
        dateLabel.text = date
        
        timeLabel.text = time
        
        focusTimeLabel.text = "\(focusTime)"
    }
}
