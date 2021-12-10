//
//  DetailImageTableViewCell.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/22.
//

import UIKit

class DetailImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var whiteView: ToastView! {
        
        didSet {
            
            whiteView.cornerRadius = 25
        }
    }
}
