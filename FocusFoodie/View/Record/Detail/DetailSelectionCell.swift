//
//  DetailTagTableViewCell.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/21.
//

import UIKit

class DetailSelectionCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel! {
        
        didSet {
            
            dateLabel.text = "2021 / 10 / 20"
            
            dateLabel.textColor = .B5
        }
    }
    
    @IBOutlet weak var timeLabel: UILabel! {
        
        didSet {
            
            timeLabel.text = "17:00 - 18:00"
            
            timeLabel.textColor = .B5
        }
    }
    
    @IBOutlet weak var focusTimeLabel: UILabel! {
        
        didSet {
            
            focusTimeLabel.text = "180"
            
            focusTimeLabel.textColor = .B5
        }
    }
    
    @IBOutlet weak var unitLabel: UILabel! {
        
        didSet {
            
            unitLabel.text = "min"
            
            unitLabel.textColor = .B5
        }
    }
}
