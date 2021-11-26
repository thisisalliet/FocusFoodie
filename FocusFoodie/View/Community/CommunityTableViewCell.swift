//
//  CommunityTableViewCell.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/9.
//

import UIKit

enum CommunityLayout {
    
    case basic
    
    case withInvitation
}

class CommunityTableViewCell: UITableViewCell {
    
    weak var delegate: CommunityViewController?
    
    @IBOutlet weak var acceptButton: UIButton!
    
    @IBOutlet weak var whiteView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
        
    @IBOutlet weak var inviteBackground: UIImageView!
    
    @IBAction func acceptButtonTapped(_ sender: UIButton) {
        
    }
    
    func layoutCell(name: String, email: String) {
        
        acceptButton.isHidden = true

        nameLabel.text = name

        emailLabel.text = email
    }
    
    func layoutCellWithInvitation(name: String, email: String) {

        nameLabel.text = name

        emailLabel.text = email
    }
}
