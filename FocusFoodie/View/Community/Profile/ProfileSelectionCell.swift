//
//  ProfileSelectionCell.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/11.
//

import UIKit
import WebKit

class ProfileSelectionCell: UITableViewCell {

    @IBOutlet weak var selectionBackground: UIView! {
        
        didSet {
            
            selectionBackground.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var profileSwitch: UISwitch!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func layoutCellWithSwitch(status: Bool, category: String, image: UIImage?) {
        
        if status == true {
            
            statusLabel.text = "Enabled"
            
        } else {
            
            statusLabel.text = "Disabled"
        }
        
        titleLabel.text = category
        
        backgroundImage.image = image
    }
}
