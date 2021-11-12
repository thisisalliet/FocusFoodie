//
//  ProfileInfoCell.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/11/10.
//

import UIKit

class ProfileInfoCell: ProfileBasicCell {

    @IBOutlet weak var nameTextfield: UITextField!
    
    @IBOutlet weak var emailTextfield: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    override func layoutCellWithInfo(name: String, email: String) {
//        
//        UserManager.shared.fetchSenderInfo(senderId: <#T##String#>, completion: <#T##(Result<User, Error>) -> Void#>)
//    }
}
