//
//  RecordTableViewCell.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/20.
//

import UIKit

class RecordCell: UITableViewCell {
        
    @IBOutlet weak var timerImage: UIImageView! {
        
        didSet {
            
            timerImage.image = UIImage.asset(.icon_loading)
            
            timerImage.contentMode = .scaleAspectFit
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
            
            greyView.backgroundColor = .B2
        }
    }
    
    @IBOutlet weak var categoryLabel: UILabel! {
        
        didSet {
            
            categoryLabel.text = "Coding"
            
            categoryLabel.contentMode = .center
            
            categoryLabel.textColor = .B5
        }
    }
    
    @IBOutlet weak var minLabel: UILabel! {
        
        didSet {
            
            minLabel.text = "180"
            
            minLabel.textColor = .B5
            
        }
    }
    
    @IBOutlet weak var unitLabel: UILabel! {
        
        didSet {
            
            unitLabel.text = "min"
            
            unitLabel.textColor = .B5
        }
    }
}
