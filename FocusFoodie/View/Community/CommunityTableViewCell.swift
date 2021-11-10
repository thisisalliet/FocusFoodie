//
//  CommunityTableViewCell.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/9.
//

import UIKit

class CommunityTableViewCell: UITableViewCell {

    @IBOutlet weak var acceptButton: UIButton!
    
    @IBOutlet weak var whiteView: UIView! {
        
        didSet {
            
            whiteView.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
