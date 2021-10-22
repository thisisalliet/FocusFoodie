//
//  DetailImageTableViewCell.swift
//  FocusFoodie
//
//  Created by Allie T on 2021/10/22.
//

import UIKit

class DetailImageTableViewCell: UITableViewCell {

    @IBOutlet weak var endImageView: UIImageView! {
        
        didSet {
                        
            endImageView.frame = CGRect(
                x: 0,
                y: 0,
                width: UIScreen.width,
                height: UIScreen.height * 2 / 3)
            
            endImageView.image = UIImage.asset(.loading)
            
            endImageView.contentMode = .scaleAspectFit
        }
    }
}
