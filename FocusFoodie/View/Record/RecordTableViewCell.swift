//
//  RecordTableViewCell.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/20.
//

import UIKit

class RecordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timerImage: UIImageView! {
        
        didSet {
            
            timerImage.image = UIImage.asset(.loading)
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel! {
        
        didSet {
            
            descriptionLabel.text = "Personal Project"
        }
    }
    
    @IBOutlet weak var greyView: UIView! {
        
        didSet {
            
            greyView.cornerRadius = 5
            
            greyView.backgroundColor = .B3
        }
    }
    
    @IBOutlet weak var categoryLabel: UILabel! {
        
        didSet {
            
            categoryLabel.text = "Coding"
            
            categoryLabel.contentMode = .center
            
            categoryLabel.textColor = .B5
        }
    }
    
//    @IBOutlet weak var categoryView: CategoryView! {
//
//        didSet {
//
//            categoryView.cornerRadius = 15
//
//            categoryView.backgroundColor = .gray
//
//            categoryView.awakeFromNib()
//        }
//    }
    
    @IBOutlet weak var minLabel: UILabel! {
        
        didSet {
            
            minLabel.text = "180"
            
            minLabel.textColor = .darkGray
        }
    }
    
    @IBOutlet weak var unitLabel: UILabel! {
        
        didSet {
            
            unitLabel.text = "min"
            
            unitLabel.textColor = .darkGray
        }
    }
}
