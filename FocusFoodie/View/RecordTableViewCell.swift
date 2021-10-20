//
//  RecordTableViewCell.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/20.
//

import UIKit

@IBDesignable class RecordTableViewCell: UITableViewCell {

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
    
    @IBOutlet weak var categoryLabel: UILabel! {
        
        didSet {
            
            categoryLabel.backgroundColor = .gray
            
            categoryLabel.textColor = .white
            
            categoryLabel.cornerRadius = 10
            
            categoryLabel.text = "Coding"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
