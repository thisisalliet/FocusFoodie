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
    
    var recordOverview: Record?
    
    var createdTime: String {
        
        get {
            
            return Date.dateFormatter.string(from: Date.init(milliseconds: recordOverview!.createdTime))
        }
    }
    
    @IBOutlet weak var dateGreyView: UIView! {
        
        didSet {
            
            dateGreyView.backgroundColor = .B6
            
            dateGreyView.cornerRadius = 5
        }
    }
    
    @IBOutlet weak var dateTitleLabel: UILabel! {
        
        didSet {
            
            dateTitleLabel.text = "DATE"
            
            dateTitleLabel.textColor = .white
            
            dateTitleLabel.font = UIFont.medium(size: 16)
        }
    }
    
    @IBOutlet weak var dateLabel: UILabel! {
        
        didSet {
            
            dateLabel.text = "2021 / 10 / 20"
            
            dateLabel.textColor = .B5
        }
    }
    
    @IBOutlet weak var timeGreyView: UIView! {
        
        didSet {
            
            timeGreyView.backgroundColor = .B6
            
            timeGreyView.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var timeTitleLabel: UILabel! {
        
        didSet {
            
            timeTitleLabel.text = "TIME"
            
            timeTitleLabel.textColor = .white
            
            timeTitleLabel.font = UIFont.medium(size: 16)
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
