//
//  ProfileInfoCell.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/10.
//

import UIKit

class ProfileInfoCell: UITableViewCell {
    
    @IBOutlet weak var infoBackground: UIView! {
        
        didSet {
            
            infoBackground.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var nameTextfield: UITextField!
    
    @IBOutlet weak var emailTextfield: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    override
    func layoutCellWithInfo(name: String, email: String) {
        
        nameTextfield.text = name
        
        emailTextfield.text = email
    }
}
