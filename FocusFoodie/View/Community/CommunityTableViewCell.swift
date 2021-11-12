//
//  CommunityTableViewCell.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/9.
//

import UIKit

class CommunityTableViewCell: UITableViewCell {
    
    weak var delegate: CommunityViewController?

    @IBOutlet weak var buttonBackground: UIView!
    
    @IBOutlet weak var acceptButton: UIButton!
    
    @IBOutlet weak var whiteView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
        
    @IBOutlet weak var inviteBackground: UIImageView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func acceptButtonTapped(_ sender: UIButton) {

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
