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
            
            categoryButton.backgroundColor = .systemGroupedBackground
            
            categoryButton.cornerRadius = 10
            
            categoryButton.setTitle("Coding", for: .normal)
            
            categoryButton.setTitleColor(.black, for: .normal)
        }
    }
    
    @IBOutlet weak var dateButton: UIButton! {
        
        didSet {
            
            dateButton.backgroundColor =
        }
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var unitLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
