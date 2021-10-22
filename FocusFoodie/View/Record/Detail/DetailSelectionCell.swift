//
//  DetailTagTableViewCell.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/21.
//

import UIKit

class DetailSelectionCell: UITableViewCell {
    
    @IBOutlet weak var categoryButton: UIButton! {
        
        didSet {
            
            categoryButton.backgroundColor = UIColor.B3
            
            categoryButton.cornerRadius = 10
            
            categoryButton.setTitle("Coding", for: .normal)
            
            categoryButton.setTitleColor(UIColor.B4, for: .normal)
        }
    }
    
    @IBOutlet weak var dateButton: UIButton! {
        
        didSet {
            
            dateButton.backgroundColor = UIColor.B3
            
            dateButton.cornerRadius = 10
            
            dateButton.setTitle("2021.10.21", for: .normal)
            
            dateButton.setTitleColor(UIColor.B5, for: .normal)
        }
    }
    
    @IBOutlet weak var timeLabel: UILabel! {
        
        didSet {
            
            timeLabel.text = "180"
            
            timeLabel.textColor = UIColor.B5
        }
    }
    
    @IBOutlet weak var unitLabel: UILabel! {
        
        didSet {
            
            unitLabel.text = "min"
            
            unitLabel.textColor = UIColor.B6
        }
    }
}
