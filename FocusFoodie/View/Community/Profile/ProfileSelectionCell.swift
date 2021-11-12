//
//  ProfileSelectionCell.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/11.
//

import UIKit

class ProfileSelectionCell: ProfileBasicCell {

    @IBOutlet weak var statusLabel: UILabel! {
        
        didSet {
            
            if profileSwitch.isOn {
                
                statusLabel.text = "Enabled"
                
            } else {
                
                statusLabel.text = "Disabled"
            }
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var profileSwitch: UISwitch!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func layoutCell(category: String, status: String, image: UIImage) {
//        <#code#>
//    }
    
}
